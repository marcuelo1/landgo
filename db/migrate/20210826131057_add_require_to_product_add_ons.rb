class AddRequireToProductAddOns < ActiveRecord::Migration[6.0]
  def change
    add_column :product_add_ons, :require, :integer, default: 0
  end
end
