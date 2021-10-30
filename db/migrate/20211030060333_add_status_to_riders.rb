class AddStatusToRiders < ActiveRecord::Migration[6.0]
  def change
    add_column :riders, :status, :integer, default: 0
    remove_column :riders, :is_available
  end
end
