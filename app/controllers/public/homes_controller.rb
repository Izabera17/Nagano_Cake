class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @items = Item.limit(4).offset(1).where(is_active: 1)
  end

  def about
  end
end
