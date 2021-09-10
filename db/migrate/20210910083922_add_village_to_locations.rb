class AddVillageToLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :village, :string
    remove_column :locations, :province
    add_column :locations, :state, :string
  end
end
