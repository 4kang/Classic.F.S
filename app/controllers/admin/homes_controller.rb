class Admin::HomesController < ApplicationController

  def top
    @orders = Order.order(id: "DESC").page(params[:page])
  end

end
