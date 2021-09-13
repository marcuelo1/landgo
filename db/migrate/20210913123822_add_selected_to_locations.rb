class AddSelectedToLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :selected, :boolean, default: false
  end
end
