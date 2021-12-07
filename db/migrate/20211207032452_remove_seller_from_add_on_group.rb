class RemoveSellerFromAddOnGroup < ActiveRecord::Migration[6.0]
  def change
    remove_reference :add_on_groups, :seller, null: false, foreign_key: true
    add_column :add_on_groups, :title, :string
  end
end
