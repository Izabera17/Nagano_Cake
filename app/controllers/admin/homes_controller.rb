class Admin::HomesController < ApplicationController 
  before_action :authenticate_customer!, except: [:top]
  
  def top
    @orders = Order.page(params[:page])
  end

end
