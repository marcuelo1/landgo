class V1::Buyer::RegistrationsController < DeviseTokenAuth::RegistrationsController
    include DeviseTokenAuth::Concerns::SetUserByToken
    def create
        super
    end
    
    private
    def sign_up_params
        params.permit(:email, :password, :first_name, :last_name, :phone_number)
    end
    
end