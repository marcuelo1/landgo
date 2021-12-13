class AddSellerToAddOnGroups < ActiveRecord::Migration[6.0]
  def change
    add_reference :add_on_groups, :seller, null: false, foreign_key: true
  end
end
