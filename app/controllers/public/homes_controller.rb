class Public::HomesController < ApplicationController
  def top
    @items = Item.order('id DESC').limit(4)
    @genres = Genre.all
    @slide_items = Item.order('RANDOM()').limit(5)
  end

  def item_params
    params.require(:item).permit(:item_name, :price, :image)
  end

end
