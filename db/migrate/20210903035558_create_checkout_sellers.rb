class CreateCheckoutSellers < ActiveRecord::Migration[6.0]
  def change
    create_table :checkout_sellers do |t|
      t.references :checkout, null: false, foreign_key: true
      t.references :seller, null: false, foreign_key: true
      t.float :delivery_fee
      t.float :total

      t.timestamps
    end
  end
end
