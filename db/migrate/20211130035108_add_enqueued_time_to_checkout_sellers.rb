class AddEnqueuedTimeToCheckoutSellers < ActiveRecord::Migration[6.0]
  def change
    add_column :checkout_sellers, :enqueued_time, :datetime
  end
end
