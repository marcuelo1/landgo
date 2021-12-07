class CreateCartSellers < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_sellers do |t|
      t.references :buyer, null: false, foreign_key: true
      t.references :seller, null: false, foreign_key: true
      t.float :sub_total
      t.float :delivery_fee
      t.references :voucher, null: false, foreign_key: true
      t.float :vat
      t.float :total

      t.timestamps
    end
  end
end
