class AddCartProductToCartAddOns < ActiveRecord::Migration[6.0]
  def change
    add_reference :cart_add_ons, :cart_product, null: false, foreign_key: true
  end
end
