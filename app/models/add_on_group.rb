class AddOnGroup < ApplicationRecord
  belongs_to :seller
  has_many :add_ons, dependent: :destroy
end
