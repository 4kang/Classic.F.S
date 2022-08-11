class Public::ItemsController < ApplicationController

  def index
    @sale_items = Item.where(is_active: 0)
    @items = @sale_items.page(params[:page]).per(8)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem
  end

  private
  def item_params
    params.require(:items).permit(:genre_id, :name, :introduction, :price, :is_activ)
  end

end
