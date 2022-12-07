class Admin::HomesController < ApplicationController
  def top
    @item = Item.page(params[:page])
    @orders = Order.all
  end
end
