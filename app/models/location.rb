class Location < ApplicationRecord
  belongs_to :buyer
  
  # Geocode
  reverse_geocoded_by :latitude, :longitude
  # after_validation :reverse_geocode if :coordinates_changed? 

  def address 
    [details, street, village, city.present? ? city + " City" : "", state].compact.join(", ") 
  end 

  def address_changed? 
    street_changed? || village_changed? || city_changed? || state_changed? 
  end 

  def coordinates_changed
    latitude_changed? || longitude_changed?
  end

end
