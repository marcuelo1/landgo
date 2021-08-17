class ApplicationController < ActionController::Base

    private
    def set_admin
        @admin = current_admin
    end
end
