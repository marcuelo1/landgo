class TemplateAog < ApplicationRecord
  belongs_to :seller
  has_many :add_on_groups, dependent: :destroy
end
