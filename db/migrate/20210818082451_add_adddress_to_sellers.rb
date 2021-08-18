class AddAdddressToSellers < ActiveRecord::Migration[6.0]
  def change
    add_column :sellers, :address, :string
  end
end
