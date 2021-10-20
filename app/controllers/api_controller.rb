class ApiController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken

    private
    def set_buyer
        @buyer = current_v1_buyer
    end
    
    def update_address(latitude, longitude, location)
        geo_object = Geocoder.search([latitude, longitude]).first.data
        
        address = geo_object['address']
        print(address)
        location.street = address['road']
        location.village = address['village'] ? address['village'] : address['suburb']
        location.city = address['city']
        location.state = address['state']

        location.save
    end
end
