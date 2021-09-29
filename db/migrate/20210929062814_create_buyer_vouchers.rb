class CreateBuyerVouchers < ActiveRecord::Migration[6.0]
  def change
    create_table :buyer_vouchers do |t|
      t.references :buyer, null: false, foreign_key: true
      t.references :voucher, null: false, foreign_key: true

      t.timestamps
    end
  end
end
