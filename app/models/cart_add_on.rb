class CartAddOn < ApplicationRecord
  belongs_to :cart
  belongs_to :add_on
end
