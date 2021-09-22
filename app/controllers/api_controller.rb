class ApiController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken

    private
    def set_buyer
        @buyer = current_v1_buyer
    end
end
