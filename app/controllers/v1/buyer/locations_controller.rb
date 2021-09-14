class V1::Buyer::LocationsController < ApiController
    before_action :authenticate_v1_buyer!
    before_action :set_buyer
    before_action :set_location, only: [:select_location, :update]
    before_action :set_locations, only: [:index, :select_location]

    def index
        render json: {locations: LocationBlueprint.render(@locations), selected_location: @buyer.selected_location}, status: 200
    end

    def create
        @location = Location.new(location_params)
        geo_object = Geocoder.search([params[:latitude], params[:longitude]]).first.data
        
        address = geo_object['address']
        print(address)
        @location.street = address['road']
        @location.village = address['village'] ? address['village'] : address['suburb']
        @location.city = address['city']
        @location.state = address['state']
        @location.user = @buyer

        if @location.save
            render json: {success: true}, status: 200
        else
            render json: {error: @location.errors}, status: 500
        end
    end

    def update
        @location.update(location_params)

        render json: {success: true}, status: 200
    end

    def select_location
        @locations.update(selected: false)

        @location.update(selected: true)

        render json: {success: true}, status: 200
    end

    private
    def location_params
        params.permit(:latitude, :longitude, :details, :name)
    end

    def set_location
        @location = Location.find(params[:id])
    end

    def set_locations
        @locations = @buyer.locations 
    end
end
