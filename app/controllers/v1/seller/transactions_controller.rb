class V1::Seller::TransactionsController < SellerController
    def pending
        pending_checkout_sellers = @seller.checkout_sellers.pending
        pending_checkout_sellers = transaction_details(pending_checkout_sellers)

        render json: {pending_transactions: pending_checkout_sellers}, status: 200
    end

    def accept
        checkout_seller = CheckoutSeller.find(params[:transaction_id])
        checkout_seller.update(status: 1)
        checkout_seller.reload

        render json: {transaction: checkout_seller}, status: 200
    end

    def to_deliver
        checkout_seller = CheckoutSeller.find(params[:transaction_id])
        checkout_seller.update(status: 2)
        checkout_seller.reload

        render json: {transaction: checkout_seller}, status: 200
    end
end