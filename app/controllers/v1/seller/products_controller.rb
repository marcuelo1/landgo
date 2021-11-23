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

        render json: {
            product_categories: categories
        }, status: 200
    end
end