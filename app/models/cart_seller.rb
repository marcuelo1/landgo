class CartSeller < ApplicationRecord
  belongs_to :buyer
  belongs_to :seller
  belongs_to :voucher
end
