class V1::Rider::RidersController < RiderController
    
    def home
        
    end

    def is_signed_in
        render json: {success: true}, status: 200
    end
end
