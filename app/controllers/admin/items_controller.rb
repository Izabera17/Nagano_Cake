class Admin::ItemsController < ApplicationController
  def index
     @items = Item.all
  end

  def new
    @items = Item.new 
  end

  def create
    @items = Item.new(item_params)
    if @items.save!
      redirect_to admin_items_path
    else
      @items = Item.all 
      render :edit
    end
  end

  def show
  end

  def edit
  end
  
  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active, :image)
  end
end
