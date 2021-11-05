class AddAcceptanceRateToRiders < ActiveRecord::Migration[6.0]
  def change
    add_column :riders, :acceptance_rate, :float, default: 0
  end
end
