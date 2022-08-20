class Admin::CustomersController < ApplicationController

  def index
    @customer = Customer.all
    @customer = Customer.page(params[:id])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customer_path(@customer.id)
  end

  private

  def customer_params
    params.require(:customer).permit(:full_name, :full_name_kana, :email, :post_code, :address, :telephone_number, :is_deleted, :last_name_kana, :first_name_kana, :last_name, :first_name)
  end

end
