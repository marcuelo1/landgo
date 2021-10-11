class AddFirstAndLastNameToRiders < ActiveRecord::Migration[6.0]
  def change
    add_column :riders, :first_name, :string
    add_column :riders, :last_name, :string
  end
end
