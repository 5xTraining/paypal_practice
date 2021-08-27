class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.belongs_to :product, null: false, foreign_key: true
      t.integer :quantity
      t.integer :price
      t.belongs_to :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end