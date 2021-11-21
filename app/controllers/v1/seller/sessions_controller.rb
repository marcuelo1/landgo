class V1::Seller::SessionsController < DeviseTokenAuth::SessionsController   
    include DeviseTokenAuth::Concerns::SetUserByToken

    def create
        seller = Seller.find_by(email: params[:email])
        if seller == nil 
            return render json: {status: "You don't have an account"}, status: 422
        end
        
        # if buyer_user.is_verified?
        #     super
        # else
        #     render json: {status: "Need to verify account"}, status: 401
        # end
        super
    end

    def render_create_success
        puts @resource
        render json: {data: seller_info(@resource)}, status: 200
    end
end
