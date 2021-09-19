class AddAddressToCheckouts < ActiveRecord::Migration[6.0]
  def change
    add_column :checkouts, :latitude, :float
    add_column :checkouts, :longitude, :float
    add_column :checkouts, :details, :string
  end
end
