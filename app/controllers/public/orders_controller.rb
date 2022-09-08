class Public::OrdersController < ApplicationController
  before_action :authenticate_admin!, except: [:top]

  def new
    @order = Order.new
    @customer = current_customer
  end

  def create
    @order = Order.new(order_params)
    cart_items = current_customer.cart_items.all
    if @order.save!
      cart_items.each do |cart|
        order_details = OrderDetail.new
        order_details.item_id = cart.item_id
        order_details.order_id = @order.id
        order_details.amount = cart.amount
        order_details.price = cart.item.tax_include_price
        order_details.save
      end
      redirect_to orders_complete_path
      cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.post_code= current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      @order.telephone_number = current_customer.telephone_number
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.post_code = @address.post_code
      @order.address = @address.address
      @order.name = @address.name
      @order.telephone_number = @address.telephone_number
    end
    @cart_items = current_customer.cart_items.all
  end

  def complete

  end

  def index
    @order = Order.where(customer_id: current_customer.id)
    @item = OrderDetail.all
  end

  def show
    @order = Order.find(params[:id])
    @item = OrderDetail.where(order_id: @order.id)
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :post_code, :address, :name, :customer_id, :shipping_fee, :pay_total, :telephone_number)
  end

end
