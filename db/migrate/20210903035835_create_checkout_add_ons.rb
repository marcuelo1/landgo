class CreateCheckoutAddOns < ActiveRecord::Migration[6.0]
  def change
    create_table :checkout_add_ons do |t|
      t.references :checkout_product, null: false, foreign_key: true
      t.references :add_on, null: false, foreign_key: true
      t.string :name
      t.float :price

      t.timestamps
    end
  end
end
