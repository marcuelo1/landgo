class AddOnGroup < ApplicationRecord
  belongs_to :seller
  has_many :add_ons 
  has_many :product_add_ons
end
