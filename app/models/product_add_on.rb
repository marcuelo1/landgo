class ProductAddOn < ApplicationRecord
  belongs_to :product
  belongs_to :add_on_group
end
