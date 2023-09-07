class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # email: 'guest@example.com'に一致するレコードをデータベースから探し、
      # 見つからなかった場合に新しいレコードを作成。
      # SecureRandom.urlsafe_base64は、RubyのSecureRandomモジュールの一部で、
      # ランダムなURLで安全に使用できるパスワードを生成する。
    end
  end

end
