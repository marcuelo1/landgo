class AdministratorController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_admin
    
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

    def set_product_sizes
        @product_sizes = @seller.product_sizes
    end
    
    def set_add_on_groups
        @add_on_groups = @seller.add_on_groups
    end
    
    def set_add_ons
        @add_ons = @seller.add_ons
    end

    def set_product
        @product = Product.find(params[:id])
    end

    def set_product_prices
        @product_prices = @product.product_prices
    end

    def set_product_add_on_groups
        @product_add_on_groups = @product.product_add_ons 
    end
    
end
