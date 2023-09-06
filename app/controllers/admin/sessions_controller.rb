# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
    sign_out current_customer if current_customer.present?
    #管理者としてログインする時は、ユーザーは一旦ログアウトする
    #ログアウトさせる対象(current_customer)が存在しているときにこのメソッドを実行する
  end

  # POST /resource/sign_in
  #def create
  #  super
  #end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
