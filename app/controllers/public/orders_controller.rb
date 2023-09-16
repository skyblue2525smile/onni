class Public::OrdersController < ApplicationController

  before_action :check, only: [:new]
  #newアクションの前にcheck（メソッド名）を実行する;注文情報入力画面に行く前にメソッドを実行
  #カート内に商品が入っていない場合、注文情報入力画面に遷移できないように設定

  def new
    @order = Order.new
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details

  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_option] == "0"
        @order.postal_code = current_customer.postal_code
        @order.address = current_customer.address
        @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_option] == "1"
        @address = Address.find(params[:order][:address_id])
        @order.postal_code = @address.postal_code
        @order.address = @address.address
        @order.name = @address.name
    elsif params[:order][:address_option] == "2"
        @address = Address.new
        @address.customer_id = current_customer.id
        @address.postal_code = params[:order][:postal_code]
        @address.address = params[:order][:address]
        @address.name = params[:order][:name]
        # orderのform withでcofirmに送っているparamsのカラムのデータをparams[:order][:orderのカラム名]でとってきている

        @address.save

        @order.postal_code = @address.postal_code
        @order.address = @address.address
        @order.name = @address.name
        #上記で行っていること；アドレスを新規作成して、それを新規orderの配送先に指定している
    else
      render 'new'
    end

    @cart_items = current_customer.cart_items.all
    @order.customer_id = current_customer.id
    @order.payment_amount = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    # [inject]はeachのように繰り返しを行うメソッド 配列の合計を算出していくもの
    #
    @order.postage = 800
  end

  def thanks
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    #TODO: [!]をつけるとバリデーションエラーが発生している場合、エラー内容が画面上に表示されるようになる
    # [!]はデバック：エラーが発生した時に発生要因を調査するときに使う
    # [save! create! update!]でのみ「！」は使用可能
    current_customer.cart_items.each do |cart_item|
      @ordered_item = OrderDetail.new
      @ordered_item.order_id = @order.id
      @ordered_item.item_id = cart_item.item_id
      @ordered_item.amount = cart_item.amount
      @ordered_item.purchase_price = (cart_item.item.price*1.1).floor
      @ordered_item.save
    end

    current_customer.cart_items.destroy_all
    redirect_to orders_thanks_path
  end

  private
  def order_params
    params.require(:order).permit(:postage, :method_of_payment, :postal_code, :address, :name, :payment_amount)
  end

  def check
    if current_customer.cart_items.count == 0
      flash[:alert] = "現在、カートに商品が入っておりません。商品を入れてから再度実行してください。"
      redirect_to items_path
    end
  end

end
