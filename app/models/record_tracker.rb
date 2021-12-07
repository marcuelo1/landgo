class RecordTracker < ApplicationRecord
  belongs_to :seller
  belongs_to :object, polymorphic: true
end
