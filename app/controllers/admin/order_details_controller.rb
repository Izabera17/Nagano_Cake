class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  
  def update
		@order_detail = OrderDetail.find(params[:id]) 
		@order = @order_detail.order #
		@order_detail.update(order_detail_params) #　製作ステータスの更新

		if @order_detail.crafting_status == "production" #製作ステータスが「製作作中」なら入る
			@order.update(order_status: 2) #注文ステータスを「製作中」　に更新
		elsif @order.order_details.count ==  @order.order_details.where(crafting_status: "complete").count
			@order.update(order_status: 3) #注文ステータスを「発送準備中]に更新
		end
		redirect_to admin_order_path(@order_detail.order) #注文詳細に遷移
	end

	private

	  def order_detail_params
      params.require(:order_detail).permit(:crafting_status)
    end
  end