class Admin::ProductController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_admin

    def create
        product = Product.new(product_params)
        product.save 

        redirect_to "/admin/seller/#{params[:seller_id]}"
    end

    private
    def product_params
        params.permit(:seller_id, :name, :product_category_id, :image)
    end
    
end
