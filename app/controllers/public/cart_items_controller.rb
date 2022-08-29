class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!, except: [:index]

  def index
    @cart = CartItem.where(customer_id: current_customer.id)
    @total = 0
  end

  def create
    @cart_item = CartItem.new(cart_params)
    @cart_item.customer_id = current_customer.id
      if params[:amount].present?
         @cart_item.save
         redirect_to cart_items_path
      else
         redirect_to request.referer,notice: '個数を入れてください'
      end
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(amount: cart_params[:amount].to_i)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    cart_item = CartItem.where(customer_id: current_customer.id)
    cart_item.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
