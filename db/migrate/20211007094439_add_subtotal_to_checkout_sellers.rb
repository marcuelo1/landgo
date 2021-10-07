class AddSubtotalToCheckoutSellers < ActiveRecord::Migration[6.0]
  def change
    add_column :checkout_sellers, :subtotal, :float, default: 0
  end
end
