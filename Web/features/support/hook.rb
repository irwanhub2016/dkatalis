Before do |scenario|
  Capybara.app_host = ENV['BASE_URL']
  Capybara.default_max_wait_time = DEFAULT_TIMEOUT
  Capybara.javascript_driver = ENV['BROWSER'].to_sym

  @driver = page.driver
  @app = InitializePages.new

  if $feature_name.nil?
    $feature_name = scenario.feature.name
  elsif $feature_name != scenario.feature.name
    $feature_name = scenario.feature.name
    Capybara.current_session.driver.browser.manage.delete_all_cookies
    visit ENV['BASE_URL']
    sleep 3
    Capybara.current_session.driver.browser.manage.delete_all_cookies
    @app.home.load
  end

  @scenario = scenario
  @scenario_name = scenario.name
  @step_list = []
  @scenario.test_steps.each { |x| @step_list << x.text unless x.text.include? 'hook' }
  page.driver.browser.manage.window.resize_to(1440, 877)
  p "Feature: #{$feature_name}"
  p "Scenario: #{@scenario_name}"
end

After do |scenario|
  if scenario.failed?
    p "test failed! #{@scenario_name}"
    p "Getting screen shoot in session #{Capybara.session_name}"
    Capybara.using_session_with_screenshot(Capybara.session_name.to_s) do
    end
  end
  if scenario.source_tag_names.include? '@continue'
    Capybara.current_session.instance_variable_set(:@touched, false)
  else
    Capybara.current_session.driver.quit
  end
end
