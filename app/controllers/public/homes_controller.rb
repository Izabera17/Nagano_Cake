class Public::HomesController < ApplicationController
  def top
   @genres = Genre.all 
    @items = Item.last(4).reverse
  end
  
  def about
  end
end
