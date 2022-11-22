class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.integer :item_id, foreign_key: true, null: false
      t.integer :order_id, foreign_key: true, null: false
      t.integer :purchase_amount, null: false
      t.integer :amount, null: false
      t.integer :crafting_status, null: false, default: 0
      t.timestamps null: false
    end
  end
end
