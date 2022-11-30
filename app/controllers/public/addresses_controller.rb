class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = Address.all
  end

  def edit
  end

  def create
    @address = Address.new(address_params)

    if @address.save!
      redirect_to addresses_path
    else
      @addresses = Address.all
      render :index
    end
  end

  def destroy
  end
  
  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address, :customer_id)
  end
  
end
