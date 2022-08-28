class Public::ItemCommentsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    item_comment = item.item_comments.build(item_comment_params)
    item_comment.customer_id = current_customer.id
    if item_comment.save
       flash[:success] = "コメントしました"
       redirect_to item_path
    else
      flash[:success] = "コメントできませんでした"
      redirect_to root_path
    end

  end

  private

  def item_comment_params
    params.require(:item_comment).permit(:comment, :rate)
  end

end
