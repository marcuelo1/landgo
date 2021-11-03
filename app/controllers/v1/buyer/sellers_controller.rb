class V1::Buyer::SellersController < BuyerController

    def index
        category = Category.find(params[:id])
        category_deals = category.category_deals 

        render json: {
            category_deals: [],
            top_sellers: sellers_info(Seller.top_sellers),
            recent_sellers: sellers_info(@buyer.recent_sellers),
            all_sellers: sellers_info(Seller.all_sellers(@buyer)),
        }
    end

    def show
        @seller = Seller.find(params[:id])
        
        render json: {
            product_categories: product_categories_info(@seller.product_categories),
            products: products_info(@seller.products),
        }, status: 200
    end
end
