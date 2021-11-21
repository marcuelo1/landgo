class V1::Seller::SellersController < SellerController
    def profile
        render json: {seller: seller_info(@seller)}, status: 200
    end
end