class Address < ApplicationRecord

  belongs_to :customer

  validates :postal_code, length: {is: 7}, numericality: { only_integer: true }
  # 郵便番号の文字数は「7」、整数のみで制限
  # [numericality]は属性に数値のみが使われていることを検証するヘルパー
  validates :name, presence: true
  validates :address, presence: true

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end

end
