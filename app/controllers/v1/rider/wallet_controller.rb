class V1::Rider::WalletController < RiderController
    
    def index
        rider = rider_info(@rider)
        wallet = @rider.wallet
        wallet_amount = wallet.amount

        render json: {rider: rider, wallet_amount: wallet_amount}, status: 200
    end
end
