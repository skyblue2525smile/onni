class ApplicationController < ActionController::Base
  private

  # def after_sign_in_path_for(resource_or_scope)
  #   if resource_or_scope == :admin
  #     admin_root_path
  #   else resource_or_scope == :public
  #     customer_path(@customer.id)
  #   end
  #   #ログイン主がadminの時、ログイン後の遷移先はadminのトップ画面になる
  #   #ログイン主がcustomerの時、ログイン後の遷移先はcustomerのshow画面になる
  # end

  def after_sign_out_path_for(resource)
    if resource == :admin
      new_admin_session_path
    else
      root_path
    end
    #ログイン主がadminの時、ログアウト後の遷移先はログイン画面になる
    #ログイン主がcustomerの時、ログアウト後の遷移先はpublicのトップ画面になる
  end
end