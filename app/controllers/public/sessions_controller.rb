# frozen_string_literal: true
class Public::SessionsController < Devise::SessionsController

  def after_sign_in_path_for(resource)
    @name = current_customer.first_name
    flash[:notice] = "ようこそ、" + @name + "さん！"
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end


  before_action :customer_state, only: [:create]

  protected

  def customer_state
    @customer = Customer.find_by(email: params[:customer][:email])
    return if !@customer
      if (@customer.valid_password?(params[:customer][:password]) && (@customer.is_deleted == true))
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_customer_registration_path
      end
      flash[:notice] = "項目を入力してください"
    end
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

