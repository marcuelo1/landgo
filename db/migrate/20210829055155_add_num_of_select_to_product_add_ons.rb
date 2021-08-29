class AddNumOfSelectToProductAddOns < ActiveRecord::Migration[6.0]
  def change
    add_column :product_add_ons, :num_of_select, :integer, default: 1
  end
end
