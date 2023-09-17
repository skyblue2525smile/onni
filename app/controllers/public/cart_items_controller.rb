class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    # @sumはカート内商品の個数の合計値を表示するために使用
    @sum = 0
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      @item = Item.find(params[:id])
      render item_path(@item.id)
    end
  end

  #カート内商品を全て削除
  def destroy_all
    CartItem.destroy_all
    redirect_to cart_items_path
  end

  #カート内商品の一部を削除
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def create
    # cart_itemを定義（find_byでどの情報のアイテムを持ってくるのかパラメータを参考に記述）
    cart_item = current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])
      #すでに追加する商品がカートにある場合
      if cart_item.present?
        total_amount = cart_item.amount + cart_item_params[:amount].to_i
        cart_item.update_attribute(:amount, total_amount)
      #初めて対象商品をカートに追加する場合
      else
        cart_item_new = CartItem.new(cart_item_params)
        unless cart_item_new.save
          return redirect_to item_path(cart_item_params[:item_id]), alert: cart_item_new.errors.full_messages.first
          # 商品個数がnilであった場合、画面表示はカート画面のまま、alertが発動する
        end
      end
       redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end
end

