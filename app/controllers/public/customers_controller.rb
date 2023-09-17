class Public::CustomersController < ApplicationController
  def my_page
   @customer = current_customer
  end
  # ルーティングで[show]アクション=>[my_page]アクションと定義した為、
  # コントローラのアクション名とview名も[my_page]にする

  def confirm
    @customer = Customer.find(current_customer.id)
  end

  def withdrawal
    @customer = Customer.find(current_customer.id)
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  # 注意！ [edit/update]はdviseに同じルーティングのものがあるため、dviseのものを使っている
  # [edit/updateアクション]とparamsはregistrations_controllerに移動した
end