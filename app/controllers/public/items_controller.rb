class Public::ItemsController < ApplicationController
  
  def index
    @items = Item.page(params[:page]).per(8)
    @quantity = Item.count
    @genres = Genre.all
  end

  def show
    @items = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end

  def search
    @items = Item.where(genre_id: params[:format]).page(params[:page]).per(8)
    @quantity = Item.where(genre_id: params[:format]).count
    @genres = Genre.all
    @genre = @genres.find(params[:format])
    render 'index'
  end

end