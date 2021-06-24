module BaseHelper
  def custom_wait(time_out = 3)
    Selenium::WebDriver::Wait.new(timeout: time_out, interval: 0.5, ignore: Selenium::WebDriver::Error::NoSuchElementError)
  end

  def parse_rp(amount)
    amount.delete('Rp').delete(',').delete(' ')
  end
end
