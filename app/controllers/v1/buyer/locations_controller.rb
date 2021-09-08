class V1::Buyer::LocationsController < ApplicationController
    before_action :authenticate_v1_buyer!
    before_action :set_buyer

    def index
        @locations = @buyer.locations 

        render json: {locations: @locations}, status: 200
    end

    def create
        @location = Location.new(location_params)
    end

    private
    def location_params
        params.permit(:latitude, :longitude)
    end
end
