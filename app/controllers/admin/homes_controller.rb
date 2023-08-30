class Admin::HomesController < ApplicationController
  def top
    @orders = Order.page(params[:page])
    # 注文履歴一覧を管理者側ログイン後トップページで表示する
  end
end
