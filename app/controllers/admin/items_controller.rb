class Admin::ItemsController < ApplicationController

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def index
    @items = Item.all
    @items = Item.page(params[:page])
  end

  def create
    @item = Item.new(item_params)
    if @item.save
    redirect_to admin_item_path(@item.id), notice: "商品の追加に成功しました"
    else
     flash[:alert] = "商品の追加に失敗しました"
     render :new
    end

  end

  def show
    @item = Item.find(params[:id])
    @genre = @item.genre
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to admin_item_path(@item.id)
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price, :is_active, :genre_id)
  end

end
