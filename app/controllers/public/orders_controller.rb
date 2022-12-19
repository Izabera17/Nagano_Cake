class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @order = Order.new
    @address = Address.new
  end

  def index
    @orders = current_customer.orders.page(params[:page])
  end

  def information
    @order = Order.new(order_params)

    if params[:order][:select_address] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name+current_customer.last_name


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
    @order.save!
    current_customer.cart_items.each do |cart_item|
      @order_item = OrderDetail.new
      @order_item.item_id = cart_item.item_id
      @order_item.amount = cart_item.amount
      @order_item.purchase_amount = (cart_item.item.price*1.1).floor
      @order_item.order_id = @order.id
      @order_item.save!
    end

    current_customer.cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def show
    @order = Order.find(params[:id])
    @order_detail = @order.order_details
    @total = 0
  end
  
  private

  def order_params
    params.require(:order).permit(:payment_method, :address, :postage, :postal_code, :name, :billing_amount, :order_status)
  end

end
