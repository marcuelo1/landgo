class AddPriceToProductSizes < ActiveRecord::Migration[6.0]
  def change
    add_column :product_sizes, :price, :float
  end
end
