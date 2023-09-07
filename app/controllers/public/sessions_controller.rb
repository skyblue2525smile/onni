# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
   def new
     super
     sign_out current_admin if current_admin.present?
   end
   #ユーザーとしてログインする時は、管理者は一旦ログアウトする
   #ログアウトさせる対象(current_admin)が存在しているときにこのメソッドを実行する

  def guest_sign_in
    end_user = EndUser.guest
    sign_in end_user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected
  # 退会しているかを判断するメソッド
  def customer_state
    @customer = Customer.find_by(email: params[:customer][:email])
    # 【処理内容1】 ログイン画面で入力されたemailからCustomerモデルに同じemailのアカウントが存在するかを検索
    return if !@customer
    # アカウントを取得できなかった場合、このメソッドを終了する

    if @customer.valid_password?(params[:customer][:password]) && !@customer.is_deleted

    else redirect_to new_customer_registration_path

    end
    # 【処理内容2】「1」のアカウントが存在している場合、取得したアカウントのパスワードと
    #  入力されたパスワードが一致しているかを判別
    # 【処理内容3】「1」と「2」の処理が真(true)だった場合、そのアカウントのis_deletedカラムに格納されている値を確認
    #                is_deletedの値がtrue(退会している)の場合；サインアップ画面に遷移する処理を実行する
    #                is_deletedの値がfalse(退会していない)の場合;createアクション(ログイン処理)を実行させる
  end

end
