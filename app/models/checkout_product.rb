class CheckoutProduct < ApplicationRecord
  belongs_to :checkout_seller
  belongs_to :product
  belongs_to :product_price
  has_many :checkout_add_ons, dependent: :destroy
end
