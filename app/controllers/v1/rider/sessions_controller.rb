class V1::Rider::SessionsController < DeviseTokenAuth::SessionsController   
    include DeviseTokenAuth::Concerns::SetUserByToken

    def create
        rider = Rider.find_by(email: params[:email])
        if rider == nil 
            return render json: {status: "You don't have an account"}, status: 422
        end

        super
        
        # if buyer_user.is_verified?
        #     super
        # else
        #     render json: {status: "Need to verify account"}, status: 401
        # end
    end
end
