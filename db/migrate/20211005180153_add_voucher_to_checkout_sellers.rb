class AddVoucherToCheckoutSellers < ActiveRecord::Migration[6.0]
  def change
    add_reference :checkout_sellers, :voucher, null: true, foreign_key: true
  end
end
