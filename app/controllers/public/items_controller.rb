class Public::ItemsController < ApplicationController
  def index
    @items = Item.where(is_active: 1).page(params[:page]).per(8) # where文で販売ステータスが販売中のものだけ表示させる/ページネーションの追加/8件ごとにページ作成
    @quantity = Item.count # quantity => 総量/.count =>カウントメソッド、配列の要素の数を数えるための機能
    @genres = Genre.where(valid_invalid_status: 0) # ジャンルの有効無効ステータスが有効のものだけ探す/除外検索
  end

  def show
  end
  
   def search
    @items = Item.where(genre_id: params[:format]).page(params[:page]).per(8) # パラメーターで渡ってきたジャンルidを元に、Item内のgenre_idと完全一致する商品情報を取得している。
    @quantity = Item.where(genre_id: params[:format]).count # 検索してきたジャンルの商品数をカウント
    @genres = Genre.where(valid_invalid_status: 0)
    render 'index' # renderを使用してviewファイルを表示したときにはactionを呼び出し処理をしているわけではないため、上記のように必要な変数を用意しておく必要がある、
  end
end
