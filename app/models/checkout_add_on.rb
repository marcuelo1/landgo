class CheckoutAddOn < ApplicationRecord
  belongs_to :checkout_product
  belongs_to :add_on
end
