class Item < ApplicationRecord

  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true
  validates :image, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :is_active, inclusion: {in: [true, false]}

  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
    # このメソッドは、画像が設定されない場合は「app/assets/images」に格納されている
    # [no_image.jpg]という画像をデフォルト画像としてActiveStorageに格納し、格納した画像を表示するもの
    # ※View側で画像サイズを指定できるようにするため、[variant]を使用
  end

  def with_tax_price
    (price * 1.1).floor
  end

end
