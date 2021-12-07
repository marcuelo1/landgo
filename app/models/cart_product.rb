class CartProduct < ApplicationRecord
  belongs_to :cart_seller
  belongs_to :product
  belongs_to :product_size
end
