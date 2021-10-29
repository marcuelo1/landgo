class V1::Rider::RidersController < RiderController
    
    def home
        render json: {
            wallet: WalletBlueprint.render(@rider.wallet), 
            rider: RiderBlueprint.render(@rider)
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
end
