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
end
