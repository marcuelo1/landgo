class AddDescriptionToCheckoutProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :checkout_products, :description, :string
  end
end
