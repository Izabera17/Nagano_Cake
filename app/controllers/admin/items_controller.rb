class Admin::ItemsController < ApplicationController
  def index
     @items = Item.page(params[:page])
  end

  def new
    @items = Item.new 
  end

  def create
    @items = Item.new(item_params)
    if @items.save!
      redirect_to admin_item_path(@items.id)
    else
      @items = Item.all 
      render :index
    end
  end

  def show
     @items = Item.find(params[:id])
  end

  def edit
  end
  
  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active, :image)
  end
end
