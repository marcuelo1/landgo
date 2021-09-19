class Checkout < ApplicationRecord
  belongs_to :buyer
  belongs_to :payment_method
  has_many :checkout_sellers, dependent: :destroy
end
