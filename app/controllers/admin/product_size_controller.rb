class Admin::ProductSizeController < AdministratorController
    before_action :set_seller, only: [:new]

    def create
        product_size = ProductSize.new(product_size_params)
        product_size.save 

        redirect_to "/admin/seller/#{params[:seller_id]}"
    end

    def new
        
    end
    

    private
    def product_size_params
        params.permit(:name, :seller_id)
    end
    
end
