class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.references :buyer, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :seller, null: false, foreign_key: true
      t.integer :quantity
      t.references :product_price, null: false, foreign_key: true

      t.timestamps
    end
  end
end
