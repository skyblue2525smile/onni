class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item

  def subtotal
    item.with_tax_price * amount
  end
  #カート内の小計を求めるメソッド

end
