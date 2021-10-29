class AddIsAvailableToRiders < ActiveRecord::Migration[6.0]
  def change
    add_column :riders, :is_available, :boolean, default: true
  end
end
