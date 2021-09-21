class CreateBuyerPaymentMethods < ActiveRecord::Migration[6.0]
  def change
    create_table :buyer_payment_methods do |t|
      t.references :buyer, null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true
      t.boolean :selected, default: false

      t.timestamps
    end
  end
end
