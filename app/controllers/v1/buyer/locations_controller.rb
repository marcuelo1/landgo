class V1::Buyer::LocationsController < BuyerController
    before_action :set_location, only: [:select_location, :update]
    before_action :set_locations, only: [:index, :select_location]

    def index
        render json: {
            locations: locations_info(@locations), 
            selected_location: @buyer.selected_location ? @buyer.selected_location.id : 0, 
            current_location: location_info(@buyer.current_loc)
        }, status: 200
    end

    def create
        @location = Location.new(location_params)
        @location.user = @buyer

        if @location.save
            update_address(params[:latitude], params[:longitude], @location)
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
        @locations.reload
        
        render json: {
            success: true, 
            locations: locations_info(@locations)
        }, status: 200
    end

    private
    def location_params
        params.permit(:latitude, :longitude, :details, :name)
    end

    def set_location
        @location = Location.find(params[:id])
    end
end
