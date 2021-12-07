class AddOnGroup < ApplicationRecord
  belongs_to :template_aog
  has_many :add_ons, dependent: :destroy
end
