class V1::Rider::DeliveryController < RiderController

    def index
        rider = rider_info(@rider)
        checkout_seller = @rider.current_checkout_seller

        if checkout_seller.present?
            current_transaction = current_transaction_info(checkout_seller)
        else
            current_transaction = {}
        end

        render json: {
            rider: rider,
            current_transaction: current_transaction
        }, status: 200
    end

    def accept_transaction
        checkout_seller = CheckoutSeller.find(params[:checkout_seller_id])
        # update rider's status to 4 (On Deliver)
        @rider.update(status: 4)
        @rider.reload

        # create rider transaction
        RiderTransaction.create(
            rider_id: @rider.id,
            checkout_seller_id: checkout_seller.id,
            status: 1 # on deliver
        )

        rider = rider_info(@rider)
        current_transaction = current_transaction_info(checkout_seller)

        render json: {
            rider: rider,
            current_transaction: current_transaction
        }, status: 200
    end

    def decline_transaction
        checkout_seller = CheckoutSeller.find(params[:checkout_seller_id])
        seller = checkout_seller.seller
        # update rider's status to 4 (On Shift)
        @rider.update(status: 1)

        # remove checkout seller rider
        checkout_seller.update(rider_id: nil)
        checkout_seller.reload

        # create rider transaction
        RiderTransaction.create(
            rider_id: @rider.id,
            checkout_seller_id: checkout_seller.id,
            status: 0 # decline
        )
        # find another available rider perform later
        find_available_rider(seller.location.latitude, seller.location.longitude, checkout_seller)

        rider = rider_info(@rider)

        render json: {
            rider: rider,
            current_transaction: {}
        }, status: 200
    end

    def delivered
        checkout_seller = CheckoutSeller.find(params[:transaction_id])
        # complete checkout seller
        checkout_seller.update(status: 3)
        checkout_seller.reload 

        # update rider's wallet and status

        render json: {success: true}, status: 200
    end
end
