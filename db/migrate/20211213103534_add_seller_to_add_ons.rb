class AddSellerToAddOns < ActiveRecord::Migration[6.0]
  def change
    add_reference :add_ons, :seller, null: false, foreign_key: true
  end
end
