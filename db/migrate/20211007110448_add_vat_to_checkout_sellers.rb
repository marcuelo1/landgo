class AddVatToCheckoutSellers < ActiveRecord::Migration[6.0]
  def change
    add_column :checkout_sellers, :vat, :float
  end
end
