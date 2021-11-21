class SellerController < ApiController
    before_action :authenticate_v1_seller!
    before_action :set_seller
    include SellerHelper

    private
    def set_seller
        @seller = current_v1_seller
    end
end
