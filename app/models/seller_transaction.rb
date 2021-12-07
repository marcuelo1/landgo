class SellerTransaction < ApplicationRecord
  belongs_to :seller
  belongs_to :checkout_seller
end
