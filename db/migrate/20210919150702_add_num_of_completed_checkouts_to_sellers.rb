class AddNumOfCompletedCheckoutsToSellers < ActiveRecord::Migration[6.0]
  def change
    add_column :sellers, :num_of_completed_checkouts, :integer, default: 0
  end
end
