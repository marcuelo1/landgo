class CreateProductAddOns < ActiveRecord::Migration[6.0]
  def change
    create_table :product_add_ons do |t|
      t.references :product, null: false, foreign_key: true
      t.references :add_on_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
