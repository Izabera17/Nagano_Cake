class Admin::ItemsController < ApplicationController
  
  def index
    @items_p = Item.page(params[:page])
    if params[:genre_id]
      # Categoryのデータベースのテーブルから一致するidを取得
      @genre = Genre.find(params[:genre_id])
       
      # category_idと紐づく投稿を取得
      @items = @genre.items.order(created_at: :asc).all
    else
      # 投稿すべてを取得
      @items = Item.order(created_at: :asc).all
    end
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
    binding.pry
  end

  def show
    @items = Item.find(params[:id])
  end
  
  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to admin_item_path(item.id)
  end

  def edit
    @items = Item.find(params[:id])
  end
  
  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :is_active, :image, :genre_id)
  end
end
