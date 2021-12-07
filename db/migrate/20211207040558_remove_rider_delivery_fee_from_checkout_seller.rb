class RemoveRiderDeliveryFeeFromCheckoutSeller < ActiveRecord::Migration[6.0]
  def change
    remove_column :checkout_sellers, :rider_delivery_fee, :float
  end
end
