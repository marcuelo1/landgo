class CheckoutSeller < ApplicationRecord
  belongs_to :checkout
  belongs_to :seller
  belongs_to :voucher, optional: true
  has_many :checkout_products, dependent: :destroy

  enum status: {:Pending => 0, :Current => 2, :Completed => 3, :Canceled => 4, :Preparing => 5, :Delivering => 6}
end
