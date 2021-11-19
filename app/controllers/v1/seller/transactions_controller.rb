class V1::Seller::TransactionsController < SellerController
    def pending
        pending_checkout_sellers = @seller.checkout_sellers.pending

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

    def details
        checkout_seller = CheckoutSeller.find(params[:transaction_id])
        order = checkout_seller.checkout_products.collect do |cp|
            {
                product_id: cp.product_id,
                quantity: cp.quantity,
                size: cp.product_price.product_size.name,
                add_ons: cp.add_ons.pluck(:name)
            }
        end 

        render json: {order: order}, status: 200
    end
end