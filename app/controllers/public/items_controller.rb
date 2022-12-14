class Public::ItemsController < ApplicationController

  def index
    @sale_items = Item.where(is_active: 0)
    @items = @sale_items.page(params[:page]).per(16)
    @genres = Genre.all
  end

  def show
    @sale_items = Item.where(is_active: 0)
    @items = @sale_items.page(params[:page]).per(4)
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @item_comments = @item.item_comments
    @item_comment = ItemComment.new
  end

  def item_search
    @model = params[:model]
    if @model == "item"
      if params[:content] == ""
        flash[:danger] = "商品名を入力してください"
        redirect_to root_path
      else
        @genres = Genre.all
        @search_name = params[:content]
        @search_result = Item.search_for(@model, @search_name).page(params[:page]).per(8)
      end
    else
      @genres = Genre.all
      search_genre = params[:genre_id]
      @search_result = Item.search_for(@model, search_genre).page(params[:page]).per(8)
      @search_name = Genre.find(search_genre).name
    end
  end

  private

  def item_params
    params.require(:items).permit(:genre_id, :name, :introduction, :price, :is_activ, :comment)
  end

end