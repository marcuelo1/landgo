class Admin::ProductSizeController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_admin

    def create
        product_size = ProductSize.new(product_size_params)
        product_size.save 

        redirect_to "/admin/seller/#{params[:seller_id]}"
    end

    private
    def product_size_params
        params.permit(:name, :seller_id)
    end
    
end
