class CheckoutSeller < ApplicationRecord
  belongs_to :checkout
  belongs_to :seller
  has_many :checkout_products, dependent: :destroy
end
