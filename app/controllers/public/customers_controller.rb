class Public::CustomersController < ApplicationController
  def my_page
   @customer = current_customer
  end

  def confirm
    @customer = Customer.find(current_customer.id)
  end

  def withdrawal
    @customer = Customer.find(current_customer.id)
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
end