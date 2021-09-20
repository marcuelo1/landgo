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

    def set_locations
        @locations = @buyer.locations 
    end

    def set_payment_methods
        @payment_methods = PaymentMethod.all
    end
end
