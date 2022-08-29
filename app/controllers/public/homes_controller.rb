class Public::HomesController < ApplicationController

  def top
    @items = Item.order('id DESC').limit(4)
    @genres = Genre.all
    @slide_items = Item.order('RANDOM()').limit(5)
  end

end
