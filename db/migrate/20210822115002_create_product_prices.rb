class CreateProductPrices < ActiveRecord::Migration[6.0]
  def change
    create_table :product_prices do |t|
      t.float :price
      t.references :product, null: false, foreign_key: true
      t.references :product_size, null: false, foreign_key: true

      t.timestamps
    end
  end
end
