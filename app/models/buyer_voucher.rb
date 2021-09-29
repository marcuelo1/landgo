class BuyerVoucher < ApplicationRecord
  belongs_to :buyer
  belongs_to :voucher
end
