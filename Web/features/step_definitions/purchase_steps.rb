Given 'user access to main page' do
  @app.home.load
  custom_wait.until { @app.home.has_buy_now_btn? }
end

When 'user able to purchase a pillow with {string}' do |status|
  get_purchase_data = DataMagic.load 'purchase.yml'

  @app.home.buy_now_btn.click

  # generate customer data
  @customer_details = {
    name: Faker::Name.unique.first_name + Faker::Name.unique.last_name,
    email: Faker::Internet.free_email,
    phone_no: Faker::Number.number(digits: 7).to_s,
    city: Faker::Nation.capital_city,
    address: Faker::Address.full_address,
    postal_code: Faker::Address.zip_code,
    amount: Faker::Number.number(digits: 5)
  }

  custom_wait.until { @app.home.has_checkout_btn? }

  @app.home.fill_purchase(@customer_details)

  # fill credit card detail in midtrans frame
  @app.checkout_order.checkout_by_midtrans_frame do |frame|
  	@frame = frame
    frame.checkout_btn.click
    custom_wait.until { frame.has_select_credit_card? }
    frame.select_credit_card.click
    custom_wait.until { frame.has_input_card_number? }
    frame.input_card_number.set get_purchase_data["#{status}_credit_card_payment"]['card_number']
    frame.input_expiry_date.set get_purchase_data["#{status}_credit_card_payment"]['expire_date']
    frame.input_cvv.set get_purchase_data["#{status}_credit_card_payment"]['cvv_number']
    frame.pay_now_btn.click
  end

  # submit Bank OTP
  unless status.eql? 'failed'
    custom_wait.until { @frame.has_no_pay_now_btn? }
    frames = page.find_all('iframe')
    page.driver.switch_to_frame(frames[0])
    final_payment_frames = page.find_all('iframe')
    page.driver.switch_to_frame(final_payment_frames[0])
    sleep 2
    custom_wait.until { page.has_css?('button.btn-sm.btn-success') }
    page.find(:css, 'input#PaRes').set get_purchase_data["#{status}_credit_card_payment"]['bank_otp']
    page.find(:css, 'button.btn-sm.btn-success').click
    @page = page
  end
end

Then('user verify purchase should be {string} created') do |status|
	if status.eql? 'success'
		custom_wait.until { @page.has_no_css?('button.btn-sm.btn-success') }

	    # waiting to automatically redirected to home page in 4 seconds if submit payment has been successful
	    sleep 4

	    # there's an issue compatibility on firefox when switch from second(child) level frame to main page
		unless ENV['BROWSER'].eql? 'firefox'
		   	custom_wait(5).until { @app.home.has_buy_now_btn? }
		   	expect(@app.home.has_notif_success?).to be true
		 end
	else
		@app.checkout_order.checkout_by_midtrans_frame do |frame|
			expect(frame.has_notif_error?).to be true
		end
	end
end