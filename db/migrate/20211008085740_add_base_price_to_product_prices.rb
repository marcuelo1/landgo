class AddBasePriceToProductPrices < ActiveRecord::Migration[6.0]
  def change
    add_column :product_prices, :base_price, :float, default: 0
  end
end
