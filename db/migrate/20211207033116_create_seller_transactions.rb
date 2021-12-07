class CreateSellerTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :seller_transactions do |t|
      t.references :seller, null: false, foreign_key: true
      t.references :checkout_seller, null: false, foreign_key: true
      t.float :sub_total
      t.float :fees_amount
      t.float :total
      t.boolean :is_paid
      t.string :payment_method

      t.timestamps
    end
  end
end
