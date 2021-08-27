class ApplicationController < ActionController::Base

  helper_method :current_cart

  private
  def current_cart
    @cart9527 ||= Cart.from_hash(session[:cart9527])
  end
end
