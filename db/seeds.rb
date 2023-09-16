# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: "a@a",## 任意のメールアドレス
  password: "aaaaaa"## 任意のパスワード
)

#  作成するテストデータ（本番環境で使用）：ユーザー情報、商品情報、配送先、ジャンル

#  取得または登録したインスタンス = モデル.find_or_create_by!(検索キー: 検索する値) do |ブロック変数|
#  [find_or_create_by!];指定したデータを検索し、そのデータがある場合は取得
#  ない場合は検索キーで指定した値と「do~end」で指定した値でデータを登録するメソッド
#   ブロック変数.属性 = 登録する値
#   :
#   :
# end

# putsメソッドを使用して操作内容を文字で表示
puts "seedの実行を開始"

# ユーザー情報の新規登録
yamada = Customer.find_or_create_by!(email: "yamada@example.com") do |customer|
  customer.encrypted_password = "password"
  customer.last_name = "山田"
  customer.first_name = "花子"
  customer.last_name_kana = "ヤマダ"
  customer.first_name_kana = "ハナコ"
  customer.postal_code = "0000000"
  customer.address = "東京都渋谷区渋谷0-0-000"
  customer.telephone_number = "00000000000"
end

kumamoto = Customer.find_or_create_by!(email: "kumamoto@example.com") do |customer|
  customer.encrypted_password = "password"
  customer.last_name = "熊本"
  customer.first_name = "大樹"
  customer.last_name_kana = "クマモト"
  customer.first_name_kana = "ダイキ"
  customer.postal_code = "0000000"
  customer.address = "奈良県奈良市0-0-000"
  customer.telephone_number = "00000000000"
end

handa = Customer.find_or_create_by!(email: "handa@example.com") do |customer|
  customer.encrypted_password = "password"
  customer.last_name = "半田"
  customer.first_name = "清子"
  customer.last_name_kana = "ハンダ"
  customer.first_name_kana = "キヨコ"
  customer.postal_code = "0000000"
  customer.address = "福井県福井市0-0-000"
  customer.telephone_number = "00000000000"
end

#商品の新規登録
Item.find_or_create_by!(name: "ガラスのイヤリング") do |item|
  item.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-item1.jpg"), filename:"sample-item1.jpg")
  item.introduction = "濃い青色のガラスのイヤリングです。"
  item.price = "1,400"
end

Item.find_or_create_by!(name: "ガラスのイヤリング") do |item|
  item.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-item1.jpg"), filename:"sample-item1.jpg")
  item.introduction = "薄い紫色のガラスのイヤリングです。"
  item.price = "1,400"
end

Item.find_or_create_by!(name: "ガラスのピアス") do |item|
  item.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-item1.jpg"), filename:"sample-item1.jpg")
  item.introduction = "薄い青色のガラスのピアスです。"
  item.price = "1,400"
end

#配送先の新規登録(マイページや注文画面にて登録する配送先)
Adress.find_or_create_by!(name: "福田郷太") do |address|
  address.postal_code = "0000000"
  address.address = "神奈川県横浜市0-0-000"
end

Adress.find_or_create_by!(name: "宮本真紀子") do |address|
  address.postal_code = "0000000"
  address.address = "埼玉県さいたま市0-0-000"
end

#ジャンルの登録(今回は使用しないが、今後の参考のために記述)
Genre.find_or_create_by!(name: "イヤリング") do |genre|
  genre.name = "イヤリング"
end

Genre.find_or_create_by!(name: "ピアス") do |genre|
  genre.name = "ピアス"
end

puts "seedの実行が完了しました"



