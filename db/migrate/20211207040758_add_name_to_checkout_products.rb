class AddNameToCheckoutProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :checkout_products, :name, :string
  end
end
