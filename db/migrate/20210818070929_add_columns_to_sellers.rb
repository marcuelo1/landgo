class AddColumnsToSellers < ActiveRecord::Migration[6.0]
  def change
    add_column :sellers, :phone_number, :string
    add_reference :sellers, :category, null: false, foreign_key: true
    remove_column :sellers, :image
  end
end
