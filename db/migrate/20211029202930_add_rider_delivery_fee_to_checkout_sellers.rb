class AddRiderDeliveryFeeToCheckoutSellers < ActiveRecord::Migration[6.0]
  def change
    add_column :checkout_sellers, :rider_delivery_fee, :float, default: 0
  end
end
