class AddRiderToCheckoutSellers < ActiveRecord::Migration[6.0]
  def change
    add_reference :checkout_sellers, :rider, null: false, foreign_key: true
  end
end
