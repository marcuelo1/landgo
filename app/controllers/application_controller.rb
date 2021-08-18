class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token

    private
    def set_admin
        @admin = current_admin
    end

    def set_categories
        @categories = Category.all 
    end
    
    def set_sellers
        @sellers = Seller.all
    end
    
end
