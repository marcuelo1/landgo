class Product < ApplicationRecord
  include PgSearch::Model
  multisearchable(
    against: [:name], 
    update_if: :name_changed?
  )

  belongs_to :product_category
  belongs_to :seller

  has_one_attached :image
  has_many :product_sizes, dependent: :destroy
  has_one :template_aog, dependent: :destroy
  has_many :add_on_groups, through: :template_aog
end
