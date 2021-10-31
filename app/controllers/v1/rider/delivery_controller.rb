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

    def delivered
        checkout_seller = CheckoutSeller.find(params[:transaction_id])
        # complete checkout seller
        checkout_seller.update(status: 3)
        checkout_seller.reload 

        # update rider's wallet and status

        render json: {success: true}, status: 200
    end
end
