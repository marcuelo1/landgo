class V1::Buyer::SellersController < BuyerController
    before_action :updateCurrentLocation, only: [:index]
    before_action :set_location, only: [:index]

    def index
        category = Category.find(params[:id])
        category_deals = category.category_deals 

        render json: {
            category_deals: CategoryDealBlueprint.render(category_deals),
            top_sellers: SellerBlueprint.render(Seller.top_sellers),
            recent_sellers: SellerBlueprint.render(Seller.recent_sellers),
            all_sellers: SellerBlueprint.render(Seller.all_sellers),
        }
    end

    def show
        @seller = Seller.find(params[:id])
        
        render json: {
            product_categories: ProductCategoryBlueprint.render(@seller.product_categories),
            products: ProductBlueprint.render(@seller.products),
            seller: SellerBlueprint.render(@seller)
        }, status: 200
    end
end
