class Admin::ProductController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_admin
    before_action :set_seller, :set_product_categories, :set_product_sizes, :set_add_on_groups, only: [:new]

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

        # create product add ons
        if params[:add_on_group_ids]
            params[:add_on_group_ids].each_with_index do |_, i|
                pao = ProductAddOn.new()
                pao.product_id = product.id 
                pao.add_on_group_id = params[:add_on_group_ids][i] 
                pao.require = params[:requires][i]
                pao.save
            end
        end

        redirect_to "/admin/seller/#{params[:seller_id]}"
    end

    def new
    end
    

    private
    def product_params
        params.permit(:seller_id, :name, :product_category_id, :image, :description)
    end
    
end
