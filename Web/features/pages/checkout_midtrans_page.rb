class CheckoutByMidtransIframe < SitePrism::Page
  element :checkout_btn, 'div.button-main.show a.button-main-content'
  element :select_credit_card, :xpath, "//div[contains(text(),'Credit/Debit Card')]"
  element :input_card_number, 'div.container-fluid form div.card-container:nth-child(2) div.input-group.col-xs-12 input'
  element :input_expiry_date, 'div.container-fluid form div.card-container:nth-child(2) div.input-group.col-xs-7 input'
  element :input_cvv, 'div.container-fluid form div.card-container:nth-child(2) div.input-group.col-xs-5 input'
  element :pay_now_btn, 'a.button-main-content'
  elements :promo_checkbox, 'div.container-fluid form div.card-container:nth-child(4) div.input-group.col-xs-12 div.checkbox.checkbox-left input'
  element :amount_detail, 'div.final-panel.success div.text-success.large'
  element :notif_error, 'div.input-group.col-xs-7.error'
end

class CheckoutByMidtrans < SitePrism::Page
  iframe :checkout_by_midtrans_frame, CheckoutByMidtransIframe, 'iframe#snap-midtrans'
end
