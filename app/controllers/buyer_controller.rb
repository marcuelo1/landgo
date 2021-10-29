class BuyerController < ApiController
    before_action :authenticate_v1_buyer!
    before_action :set_buyer
    include BuyerHelper

    private

    def updateCurrentLocation
        if params[:is_current]
            current_loc = @buyer.current_loc
            current_loc.update(latitude: params[:latitude], longitude: params[:longitude])
            update_address(params[:latitude], params[:longitude], current_loc)
        end
    end

    def set_locations
        @locations = @buyer.locations 
    end

    def set_payment_methods
        @payment_methods = PaymentMethod.all
    end

    def set_checkout
        if params[:id].present?
            @checkout = Checkout.find(params[:id])
        else
            location = Location.find(params[:location_id])
            @checkout = Checkout.create(buyer_id: @buyer.id, total: 0, latitude: location.latitude, longitude: location.longitude, details: location.details, payment_method_id: params[:payment_method_id])
        end
    end
end
