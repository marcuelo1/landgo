class V1::Seller::TransactionsController < SellerController
    def pending
        pending_checkout_sellers = @seller.checkout_sellers.pending

        render json: {orders}
    end
end