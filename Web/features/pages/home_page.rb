class HomePage < SitePrism::Page
  set_url '/'

  element :page_title_heading, '.page-title-heading h2'
  element :buy_now_btn, 'a.btn.buy'
  element :input_amount, 'td.input.text-right input'
  element :input_name, :xpath, '//tbody/tr[1]/td[3]/input[1]'
  element :input_email, :xpath, '//tbody/tr[2]/td[2]/input[1]'
  element :input_phone_no, :xpath, '//tbody/tr[3]/td[2]/input[1]'
  element :input_city, :xpath, '//tbody/tr[4]/td[2]/input[1]'
  element :input_address, 'td.input textarea'
  element :input_postal_code, :xpath, '//tbody/tr[6]/td[2]'
  element :checkout_btn, 'div.cart-action div.cart-checkout'
  element :notif_success, 'div.notification-wrapper div.trans-success'

  def fill_purchase(customer_details)
    input_amount.set customer_details[:amount]
    input_name.set customer_details[:name]
    input_email.set customer_details[:email]
    input_phone_no.set customer_details[:phone_no]
    input_city.set customer_details[:city]
    input_address.set customer_details[:address]
    input_postal_code.set customer_details[:postal_code]
    checkout_btn.click
  end
end
