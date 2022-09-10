class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!, except: [:top]

  def show
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.all
    @total = @order.pay_total - @order.shipping_fee
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      if @order.status == "payment_confirmation"
         @order.order_details.each do |order_detail|
           order_detail.update(making_status: 1)
         end
      end
      redirect_to admin_order_path(@order.id)
    else
      @order = Oeder.all
      redirect_to admin_order_path(@order.id)
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
