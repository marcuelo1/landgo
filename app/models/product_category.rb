class ProductCategory < ApplicationRecord
  belongs_to :seller
  has_many :products
end
