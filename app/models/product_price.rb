class ProductPrice < ApplicationRecord
  belongs_to :product
  belongs_to :product_size
end
