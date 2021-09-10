class V1::Buyer::LocationsController < ApiController
    before_action :authenticate_v1_buyer!
    before_action :set_buyer

    def index
        @locations = @buyer.locations 

        render json: {locations: @locations}, status: 200
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

    private
    def location_params
        params.permit(:latitude, :longitude, :details, :name)
    end
end
