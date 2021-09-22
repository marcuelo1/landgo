class CheckoutSeller < ApplicationRecord
  belongs_to :checkout
  belongs_to :seller
  has_many :checkout_products, dependent: :destroy

  enum status: {:Pending => 0, :Current => 2, :Completed => 3}
end
