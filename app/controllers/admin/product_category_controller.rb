class Admin::ProductCategoryController < AdministratorController
    before_action :set_seller, only: [:new]

    def create
        pc = ProductCategory.new(product_category_params)
        pc.save 

        redirect_to "/admin/seller/#{params[:seller_id]}"
    end

    def new
        
    end
    
    
    private
    def product_category_params
        params.permit(:name, :seller_id)
    end
    
end
