class BuyerController < ApiController
    before_action :authenticate_v1_buyer!
    before_action :set_buyer

    private

    def updateCurrentLocation
        if params[:is_current]
            current_loc = @buyer.current_loc
            current_loc.update(latitude: params[:latitude], longitude: params[:longitude])
        end
    end

    def set_location
        if params[:is_current] 
            @buyer.current_loc
        else
            Location.find(params[:location_id])
        end
    end
end
