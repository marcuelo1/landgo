class AddBuyerToLocations < ActiveRecord::Migration[6.0]
  def change
    add_reference :locations, :buyer, null: false, foreign_key: true
  end
end
