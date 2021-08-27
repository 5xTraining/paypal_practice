class OrdersController < ApplicationController
  def checkout
    @order = Order.new
    @token = gateway.client_token.generate
  end

  def create
    # 建立訂單
    order = current_user.orders.build(order_params)

    current_cart.items.each do |item|
      oi = OrderItem.new(
        product: item.product,
        quantity: item.quantity,
        price: item.product.price
      )
      order.order_items << oi
    end

    order.save

    # 刷卡
    result = gateway.transaction.sale(
      amount: current_cart.total,
      payment_method_nonce: params[:nonce]
    )

    if result.success?
      order.pay!

      # 清購物車
      session[:cart9527] = nil

      # 走
      redirect_to root_path, notice: "感謝大爺!"
    else
      redirect_to root_path, notice: "交易發生錯誤!"
    end
  end

  private
  def order_params
    params.require(:order).permit(:receiver, :tel, :address)
  end

  def gateway
    Braintree::Gateway.new(
      environment: :sandbox,
      merchant_id: ENV['braintree_merchant_id'],
      public_key: ENV['braintree_public_key'],
      private_key: ENV['braintree_private_key'],
    )
  end
end
