class MoveStatusFromCheckoutToCheckoutSellers < ActiveRecord::Migration[6.0]
  def change
    add_column :checkout_sellers, :status, :integer, default: 0
    remove_column :checkouts, :status
  end
end
