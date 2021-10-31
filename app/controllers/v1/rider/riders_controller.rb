class V1::Rider::RidersController < RiderController

    def is_signed_in
        render json: {success: true}, status: 200
    end

    def profile
        rider = rider_info(@rider)
        render json: {rider: rider}, status: 200
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
