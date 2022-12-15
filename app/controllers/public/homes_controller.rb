class Public::HomesController < ApplicationController
  def top
   @genres = Genre.all 
    @items = Item.limit(4).offset(2) 
  end
  
  def about
  end
end
