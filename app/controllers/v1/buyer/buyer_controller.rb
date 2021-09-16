class V1::Buyer::BuyerController < ApiController
    before_action :authenticate_v1_buyer!
    before_action :set_buyer
    before_action :updateCurrentLocation, only: [:home_page, :list_of_stores]
    before_action :set_location, only: [:home_page, :list_of_stores]
    
    def home_page
        # location
        @categories = Category.where.not(status: 0)

        render json: {
            categories: CategoryBlueprint.render(@categories),
            products: [],
            sellers: []
        }, status: 200
    end

    def list_of_stores
        category = Category.find(params[:id])
        category_deals = category.category_deals 

        render json: {
            category_deals: CategoryDealBlueprint.render(category_deals),
            top_sellers: SellerBlueprint.render(Seller.top_sellers),
            recent_sellers: SellerBlueprint.render(Seller.recent_sellers),
            all_sellers: SellerBlueprint.render(Seller.all_sellers),
        }
    end

    def list_of_products
        seller = Seller.find(params[:id])
        
        render json: {
            product_categories: ProductCategoryBlueprint.render(seller.product_categories),
            products: ProductBlueprint.render(seller.products),
            seller: SellerBlueprint.render(seller)
        }, status: 200
    end

    def product_details
        product = Product.find(params[:id])

        render json: {
            sizes: ProductPriceBlueprint.render(product.product_prices),
            add_on_groups: AddOnGroupBlueprint.render(product.product_add_ons)
        }
    end

    private

    def updateCurrentLocation
        if params[:is_current]
            current_loc = @buyer.current_loc
            current_loc.update(latitude: params[:latitude], longitude: params[:longitude])
        end
    end

    def set_location
        if params[:is_current] 
            @buyer.current_loc
        else
            Location.find(params[:location_id])
        end
    end
end
