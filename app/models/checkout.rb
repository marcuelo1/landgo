class Checkout < ApplicationRecord
  belongs_to :buyer
  has_many :checkout_sellers, dependent: :destroy

  enum status: {:pending => 0, :current => 1, :completed => 2}
end
