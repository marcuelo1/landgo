class Product < ApplicationRecord
  belongs_to :product_category
  belongs_to :seller

  has_one_attached :image
  has_many :product_prices, dependent: :destroy
  has_many :product_add_ons, dependent: :destroy
  has_many :add_on_groups, through: :product_add_ons
end