class Product < ApplicationRecord
  include PgSearch::Model
  multisearchable(
    against: [:name], 
    update_if: :name_changed?
  )

  belongs_to :product_category
  belongs_to :seller
  belongs_to :product_template_aog, optional: true

  has_one_attached :image
  has_many :product_sizes, dependent: :destroy
end
