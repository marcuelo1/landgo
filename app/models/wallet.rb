class Wallet < ApplicationRecord
  belongs_to :user, polymorphic: true
end
