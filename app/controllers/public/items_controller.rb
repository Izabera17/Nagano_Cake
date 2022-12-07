class Public::ItemsController < ApplicationController
  def index
    @items = Item.where(is_active: 1).page(params[:page]).per(8) 
    @quantity = Item.where(is_active: 1).count 
    @genres = Genre.all
  end

  def show
    @item = Item.new
    @items = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all 
  end
  
   def search
    @items = Item.where(genre_id: params[:format]).page(params[:page]).per(8)
    @quantity = Item.where(genre_id: params[:format]).count 
    @genres = Genre.where(valid_invalid_status: 0)
    render 'index'
  end
  
end
