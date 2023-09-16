class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :email, uniqueness: true
  # [uniqueness]はオブジェクトが保存される直前に、属性の値が一意であり
  # 重複していないことを検証するヘルパー

  def active_for_authenthication?
    super && !@customer.is_deleted
  end
  # 退会済みのユーザー情報ではログインできないようにするメソッド

  def self.guest
    find_or_create_by!(email: 'guest@example.com',last_name: 'guest',first_name: 'guest',
                       last_name_kana: 'guest',first_name_kana: 'guest',postal_code: '0000000',
                       address: 'guest', telephone_number: '000000000000') do |user|
      user.password = SecureRandom.urlsafe_base64
      # email: 'guest@example.com'に一致するレコードをデータベースから探し、
      # 見つからなかった場合に新しいレコードを作成。
      # SecureRandom.urlsafe_base64は、RubyのSecureRandomモジュールの一部で、
      # ランダムなURLで安全に使用できるパスワードを生成する。
      #[.guest]:ゲストユーザーの作成するメソッドの定義
    end
  end

  def full_name
    self.last_name + " " + self.first_name
  end

  def full_name_kana
    self.last_name_kana + " " + self.first_name_kana
  end

end
