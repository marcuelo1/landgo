class CheckoutSeller < ApplicationRecord
  belongs_to :checkout
  belongs_to :seller
  belongs_to :rider, optional: true
  belongs_to :voucher, optional: true
  has_many :checkout_products, dependent: :destroy

  enum status: {:Pending => 0, :Accepted => 1, :Delivering => 2, :Completed => 3, :Cancelled => 4}
end
