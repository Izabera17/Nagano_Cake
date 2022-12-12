class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(current_customer.id)
  end

  def edit
    @customer = Customer.find(current_customer.id)
  end
  
  def update
    @customer = Customer.find(current_customer.id)
    list.update(list_params)
    redirect_to list_path(list.id) 
  end

  def confirmation
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:first_name, )
end
