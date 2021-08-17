class V1::Buyer::SessionsController < DeviseTokenAuth::SessionsController   
    include DeviseTokenAuth::Concerns::SetUserByToken

    def create
        if params[:facebook_id]

        elsif params[:google_id]

        else
            buyer_user = Buyer.find_by(email: params[:email])
            if buyer_user == nil 
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

end
