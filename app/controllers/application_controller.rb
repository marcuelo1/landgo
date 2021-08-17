class ApplicationController < ActionController::Base
    include DeviseTokenAuth::Concerns::SetUserByToken
    skip_before_action :verify_authenticity_token

    private
    def set_admin
        @admin = current_admin
    end
end
