class V1::Rider::RidersController < RiderController
    
    def home
        rider = rider_info(@rider)
        checkout_seller = @rider.checkout_seller

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

    def is_signed_in
        render json: {success: true}, status: 200
    end

    def profile
        rider = rider_info(@rider)
        render json: {rider: rider}, status: 200
    end

    def wallet
        rider = rider_info(@rider)
        wallet = @rider.wallet
        wallet_amount = wallet.amount

        render json: {rider: rider, wallet_amount: wallet_amount}, status: 200
    end

    def history
        rider = rider_info(@rider)
        render json: {rider: rider}, status: 200
    end

    def change_shift
        @rider.update(status: params[:status])
        @rider.reload

        render json: {success: true}, status: 200
    end
end
