class CreateCartProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_products do |t|
      t.references :cart_seller, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :product_size, null: false, foreign_key: true
      t.integer :quantity
      t.float :one_qty_price
      t.float :total

      t.timestamps
    end
  end
end
