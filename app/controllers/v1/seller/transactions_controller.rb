class V1::Seller::TransactionsController < SellerController
    def pending
        pending_checkout_sellers = @seller.checkout_sellers.pending

        render json: {pending_transactions: pending_checkout_sellers}, status: 200
    end
end