class ChangesInRiders < ActiveRecord::Migration[6.0]
  def change
    # removed columns
    remove_column :riders, :nickname

    # add new columns
    add_column :riders, :longitude, :float
    add_column :riders, :latitude, :float
  end
end
