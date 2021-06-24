require 'capybara/cucumber'
require 'capybara-screenshot/cucumber'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'site_prism'
require 'site_prism/table'
require 'pp'
require 'dotenv'
require 'rspec/expectations'
require 'pry'
require 'byebug'
require 'pry-byebug'
require 'chunky_png'
require 'os'
require 'imatcher'
require 'data_magic'
require 'yaml'
require 'chilkat'
require 'active_support'
require 'active_support/core_ext'
require 'active_support/core_ext/hash/indifferent_access'
require 'date'
require_relative '../helper/base_helper'

# rubocop:disable Style/MixinUsage
include RSpec::Matchers
include DataMagic
include BaseHelper

Dotenv.load
DataMagic.yml_directory = './features/data'
browser = ENV['BROWSER'].to_sym
base_url = ENV['BASE_URL']
wait_time = 60
DEFAULT_TIMEOUT = 30

# clear report files
@report_root =  File.absolute_path('./report')

if ENV['REPORT_PATH'].nil?
  puts ' ========Deleting old reports ang logs========='
  FileUtils.rm_rf(@report_root, secure: true)
end

ENV['REPORT_PATH'] ||= Time.now.strftime('%F_%H-%M-%S')
path = "#{@report_root}/#{ENV['REPORT_PATH']}"
FileUtils.mkdir_p path

options = if ENV['BROWSER'].eql? 'chrome'
            Selenium::WebDriver::Chrome::Options.new
          else
            Selenium::WebDriver::Firefox::Options.new
          end

options.add_preference(:browser, set_download_behavior: { behavior: 'allow' })
options.add_preference('plugins.always_open_pdf_externally', true)
options.add_preference(:plugins, always_open_pdf_externally: true)

Capybara.register_driver :firefox do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile['general.useragent.override'] = 'selenium'
  options = Selenium::WebDriver::Firefox::Options.new
  options.profile = profile
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.open_timeout = wait_time
  client.read_timeout = wait_time
  Capybara::Selenium::Driver.new(
    app,
    browser: :firefox,
    options: options,
    http_client: client
  )
end

Capybara.register_driver :chrome do |app|
  options.add_argument('--user-agent=selenium')
  options.add_argument('--start-maximized')
  client = Selenium::WebDriver::Remote::Http::Default.new
  caps = Selenium::WebDriver::Remote::Capabilities.chrome(
    proxy: nil,
    page_load_strategy: 'none'
  )
  client.open_timeout = wait_time
  client.read_timeout = wait_time
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options,
    http_client: client,
    # profile: profile,
    desired_capabilities: caps
  )
end

Capybara::Screenshot.register_driver(browser) do |driver, location|
  driver.browser.save_screenshot location
end

p "about to run on #{browser} to #{base_url}"
Capybara.default_driver = browser


Capybara::Screenshot.autosave_on_failure = true
Capybara::Screenshot.prune_strategy = { keep: 50 }
Capybara::Screenshot.append_timestamp = true
Capybara::Screenshot.webkit_options = {
  width: 1366,
  height: 768
}
Capybara.save_path = "#{path}/screenshots"
# rubocop:enable Style/MixinUsage
