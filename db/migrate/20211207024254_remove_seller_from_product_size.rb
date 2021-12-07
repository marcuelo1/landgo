class RemoveSellerFromProductSize < ActiveRecord::Migration[6.0]
  def change
    remove_reference :product_sizes, :seller, null: false, foreign_key: true
  end
end
