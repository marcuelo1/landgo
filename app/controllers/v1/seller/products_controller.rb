class V1::Seller::ProductsController < SellerController
    def index
        seller = Seller.find(params[:seller_id])
        products = seller.products

        render json: {
            products: products_info(products)
        }, status: 200
    end

    def product_form
        categories = @seller.product_categories.select(:id, :name)
        sizes = @seller.product_sizes.select(:id, :name)
        add_on_groups = @seller.add_on_groups

        render json: {
            product_categories: categories,
            product_sizes: sizes,
            add_on_groups: add_on_groups,
        }, status: 200
    end

    def create
        :seller_id, :name, :product_category_id, :image, :description
        # create product
        product = Product.new(
            seller_id: @seller.id,
            name: params[:name],
            description: params[:description],
            product_category_id: params[:product_category_id]
        )
        # attach image
        product.save 

        # create product price
        params[:product_sizes].each do |ps|
            product_price = ProductPrice.new()
            product_price.product_size_id = ps[:size][:id]
            product_price.product_id = product.id
            product_price.price = ps[:price]
            product_price.base_price = ps[:price]

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
    end
end