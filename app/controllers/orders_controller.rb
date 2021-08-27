class OrdersController < ApplicationController
  def checkout
    @order = Order.new
  end
end
