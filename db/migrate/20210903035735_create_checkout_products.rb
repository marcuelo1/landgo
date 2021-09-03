class CreateCheckoutProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :checkout_products do |t|
      t.references :checkout_seller, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :product_price, null: false, foreign_key: true
      t.string :size
      t.float :price
      t.integer :quantity
      t.float :total

      t.timestamps
    end
  end
end
