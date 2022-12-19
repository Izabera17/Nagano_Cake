class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @order = Order.find(params[:id])
    @order_detail = @order.order_details
  end
  
  def update
    @order = Order.find(params[:id])
  
  	if params[:order][:order_status] == "confirmation"
      @order.order_details.each do |order_detail|
        order_detail.crafting_status = "wait"
        order_detail.update(crafting_status: order_detail.crafting_status)
      end
    end
    @order.update(order_params)
    redirect_to admin_order_path(@order)
  end

  
  private
  

  def order_params
  	params.require(:order).permit(:order_status)
  end

end
