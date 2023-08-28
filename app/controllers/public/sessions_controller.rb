# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]

  protected
  # 退会しているかを判断するメソッド
  def customer_state
    @customer = Customer.find_by(email: params[:customer][:email])
    # 【処理内容1】 入力されたemailからアカウントを1件取得
    return if !@customer
    # アカウントを取得できなかった場合、このメソッドを終了する

    if @customer.valid_password?(params[:customer][:password]) && !@customer.is_deleted

    else redirect_to new_customer_registration_path

    end
    # 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致しているかを判別
    # 【処理内容3】is_deletedの値がtrueだった場合；サインアップ画面に遷移する処理を実行する
                  # is_deletedの値がfalseだった場合;createアクションを実行させる
  end

end
