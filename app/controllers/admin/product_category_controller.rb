class Admin::ProductCategoryController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_admin

    def create
        pc = ProductCategory.new(product_category_params)
        pc.save 

        redirect_to "/admin/seller/#{params[:seller_id]}"
    end
    
    private
    def product_category_params
        params.permit(:name, :seller_id)
    end
    
end
