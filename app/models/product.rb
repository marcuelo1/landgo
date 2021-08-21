class Product < ApplicationRecord
  belongs_to :product_category
  belongs_to :seller

  has_one_attached :image
end
