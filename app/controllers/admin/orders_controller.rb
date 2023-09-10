class Admin::OrdersController < ApplicationController
  def index
    # @orders = Order.page(params[:page])
    @customer = Customer.find(params[:customer_id])
    @orders = @customer.orders.page(params[:page])
  end

  def show
    @order_details = Order.find(params[:id]).order_details
    #Orderモデルから特定のorderの情報を取りだし、それに紐づくorder_detailsのデータをとってくる
    @order = Order.find(params[:id])
    @order.payment_amount =  @order.total_price
    # 上記のコードは各顧客の注文ごとの請求金額合計の算出用コード
  end

  def update
    @order_details = Order.find(params[:id]).order_details
    @order = Order.find(params[:id])

    if @order.update(order_params)
      @order_details.update_all(making_status: 1)
      # 注文ステータスが「入金確認」とき、製作ステータスを全て「製作待ち」に更新する
      redirect_to request.referer
      # request.refererで同じページ(showページ)に遷移する
    else
      redirect_to request.referer
    end
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end

end

