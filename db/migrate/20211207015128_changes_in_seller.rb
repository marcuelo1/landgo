class ChangesInSeller < ActiveRecord::Migration[6.0]
  def change
    # removed columns
    remove_column :sellers, :nickname
    remove_column :sellers, :address
    remove_column :sellers, :num_of_completed_checkouts

    # add new columns
    add_column :sellers, :is_open, :boolean, default: false
    add_column :sellers, :longitude, :float
    add_column :sellers, :latitude, :float
    add_column :sellers, :details, :string
    add_column :sellers, :street, :string
    add_column :sellers, :village, :string
    add_column :sellers, :city, :string
    add_column :sellers, :state, :string
  end
end
