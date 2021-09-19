class ApiController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken

    private
    def set_buyer
        @buyer = current_v1_buyer
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
