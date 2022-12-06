class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @address = Address.new
  end

  def information
     params[:order][:payment_method] = params[:order][:payment_method].to_i
    @order = Order.new(order_params)

    if params[:order][:select_address] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name+current_customer.first_name

    elsif  params[:order][:select_address] ==  "2"
      @order.postal_code = Address.find(params[:order][:address_id]).postal_code
      @order.address = Address.find(params[:order][:address_id]).address
      @order.name = Address.find(params[:order][:address_id]).name

    elsif params[:order][:select_address] ==  "3"
      @address = Address.new()
      @address.address = params[:order][:address]
      @address.name = params[:order][:name]
      @address.postal_code = params[:order][:postal_code]
      @address.customer_id = current_customer.id

      if @address.save
        @order.postal_code = @address.postal_code
        @order.name = @address.name
        @order.address = @address.address
      else
        render 'new'
      end
    end

    @cart_items = CartItem.where(customer_id: current_customer.id)
    @total = 0
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    current_customer.cart_items.each do |cart_item|
      @order_item = OrderItem.new #初期化宣言
      @order_item.item_id = cart_item.item_id #商品idを注文商品idに代入
      @order_item.amount = cart_item.amount #商品の個数を注文商品の個数に代入
      @order_item.purchase_amount = (cart_item.item.price*1.1).floor #消費税込みに計算して代入
      @order_item.order_id =  @order.id #注文商品に注文idを紐付け
      @order_item.save #注文商品を保存
    end

    current_customer.cart_items.destroy_all #カートの中身を削除
    redirect_to orders_thanks_path #thanksに遷移
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :address, :postage, :postal_code, :name, :billing_amount)
  end

end
