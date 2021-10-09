class AddSingleItemPriceToCarts < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :single_item_price, :float, default: 0
  end
end
