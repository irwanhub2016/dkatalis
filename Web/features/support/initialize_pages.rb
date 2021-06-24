class InitializePages
  def home
    @home ||= HomePage.new
  end

  def checkout_order
    @checkout_order ||= CheckoutByMidtrans.new
  end
end
