class BuyerPaymentMethod < ApplicationRecord
  belongs_to :buyer
  belongs_to :payment_method
end
