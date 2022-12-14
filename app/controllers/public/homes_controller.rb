class Public::HomesController < ApplicationController
  def top
   @genres = Genre.all # ジャンルの有効無効ステータスが有効のものだけ探す/除外検索
    @items = Item.limit(5) # 先頭から5つのレコードから８つを取得
  end
  
  def about
  end
end
