class Admin::ProductController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_admin

    def create
        # create product
        product = Product.new(product_params)
        product.save 

        # create product price
        params[:product_size_ids].each_with_index do |_,i|
            product_price = ProductPrice.new()
            product_price.product_size_id = params[:product_size_ids][i] 
            product_price.product_id = product.id
            product_price.price = params[:prices][i]

            product_price.save
        end

        redirect_to "/admin/seller/#{params[:seller_id]}"
    end

    private
    def product_params
        params.permit(:seller_id, :name, :product_category_id, :image)
    end
    
end
