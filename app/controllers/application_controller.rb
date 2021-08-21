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

    def set_seller
        @seller = Seller.find(params[:id])
    end

    def set_product_categories
        @product_categories = @seller.product_categories
    end
    
    def set_products
        @products = @seller.products
    end
    
end
