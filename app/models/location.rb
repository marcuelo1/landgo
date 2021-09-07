class Location < ApplicationRecord
  belongs_to :user, polymorphic: true
  
  # Geocode
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode if: coordinates_changed? 

  def address 
    [street, city, province].compact.join(", ") 
  end 

  def address_changed? 
    street_changed?||city_changed?||province_changed? 
  end 

  def coordinates_changed
    latitude_changed? || longitude_changed?
  end

  
end
