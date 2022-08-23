# frozen_string_literal: true

class Public::Customers::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def guest_sign_in
    customer = Customer.guest
    if sign_in customer
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
    else
      flash.now[:alert] = 'もう一度やり直してください。'
      redirect_to root_path
    end
  end

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

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  protected
  def after_sign_in_path_for(resource)
    root_path
  end

  def reject_customers
    @customer = current_customer
    if @customer
      if @customer.valid_password? && (@customer.is_deleted == false)
        redirect_to new_customer_registration
      end
    end
  end

end
