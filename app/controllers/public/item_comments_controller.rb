class Public::ItemCommentsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    item_comment = item.item_comments.build(item_comment_params)
    item_comment.customer_id = current_customer.id
    if item_comment.save
       flash[:success] = "コメントしました"
       redirect_to request.referer
    else
      flash[:success] = "コメントできませんでした"
      redirect_to request.referer
    end

  end

  def destroy
    item_comment = ItemComment.find(params[:id])
    item_comment.destroy
  end

  private

  def item_comment_params
    params.require(:item_comment).permit(:comment, :rate, :customer_id, :item_id)
  end

end
