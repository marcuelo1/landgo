class ChangeRiderNullInCheckoutSellers < ActiveRecord::Migration[6.0]
  def change
    change_column_null :checkout_sellers, :rider_id, true
  end
end
