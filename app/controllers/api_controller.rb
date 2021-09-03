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
            @checkout = Checkout.create(buyer_id: @buyer.id, status: 0, total: 0)
        end
    end
end
