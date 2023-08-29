class Item < ApplicationRecord

  has_many :cart_items, dependent: :destory
  has_many :order_details, dependent: :destory

  has_one_attached :image

end
