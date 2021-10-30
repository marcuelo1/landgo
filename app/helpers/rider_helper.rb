module RiderHelper
    def current_transaction_info(checkout_seller)
        checkout = checkout_seller.checkout
        seller = checkout_seller.seller
        buyer = checkout.buyer

        return {
            id: checkout_seller.id,
            seller_name: seller.name,
            seller_address: seller.location.address,
            buyer_name: buyer.name,
            buyer_address: buyer.selected_address,
            buyer_delivery_fee: checkout_seller.delivery_fee,
            rider_delivery_fee: checkout_seller.rider_delivery_fee
        }
    end
end
