class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :postal_code
      t.string :address
      t.string :name
      t.integer :postage, default: 800
      t.integer :payment_amount
      t.integer :method_of_payment, default: 0
      t.integer :order_status, default: 0


      t.timestamps
    end
  end
end
