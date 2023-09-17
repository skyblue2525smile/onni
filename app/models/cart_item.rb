class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item

  validates :amount, presence: true
  # 商品個数がnilにならないよう、バリデーションを忘れずに！
  # viewでalret表示機能もつける

  def subtotal
    item.with_tax_price * amount
  end
  # カート内の小計を求めるメソッド
  # 豆知識：簡易的なデバックは[pタグ]を使うとデバックと良い

end
