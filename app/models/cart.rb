class Cart < ApplicationRecord
  belongs_to :buyer
  belongs_to :product
  belongs_to :seller
  belongs_to :product_price

  has_many :cart_add_ons, dependent: :destroy
end
