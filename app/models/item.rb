class Item < ApplicationRecord

  has_many :cart_items, dependent: :destory
  has_many :order_details, dependent: :destory

end
