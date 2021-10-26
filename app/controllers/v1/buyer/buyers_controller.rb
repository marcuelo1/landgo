class V1::Buyer::BuyersController < BuyerController
    before_action :updateCurrentLocation, only: [:home_page]
    before_action :set_locations, only: [:review_payment_location]
    before_action :set_payment_methods, only: [:review_payment_location]
    
    def check
        render json: {success: true}, status: 200
    end
    
    def home_page
        # location
        @categories = Category.where.not(status: 0)

        render json: {
            buyer: BuyerBlueprint.render(@buyer),
            selected_location: LocationBlueprint.render(@buyer.selected_location),
            categories: CategoryBlueprint.render(@categories),
            products: ProductBlueprint.render(@buyer.recent_purchases),
            sellers: SellerBlueprint.render(Seller.top_sellers)
        }, status: 200
    end

    def is_signed_in
        render json: {success: true}, status: 200
    end

    def review_payment_location
        render json: {
            locations: LocationBlueprint.render(@locations), 
            selected_location_id: @buyer.selected_location.id,
            payment_methods: PaymentMethodBlueprint.render(@payment_methods), 
            selected_payment_method_id: @buyer.selected_payment_method.id,
        }
    end

    def product_details
        product = Product.find(params[:id])
        seller = product.seller

        render json: {
            sizes: ProductPriceBlueprint.render(product.product_prices),
            add_on_groups: AddOnGroupBlueprint.render(product.product_add_ons),
            seller: SellerBlueprint.render(seller)
        }
    end

    def update
        case params[:update_type]
        when "name"
            @buyer.update(
                first_name: params[:first_name],
                last_name: params[:last_name]
            )

            render json: {success: true}, status: 200
        when "email"
            @buyer.update(
                email: params[:email],
            )

            render json: {success: true}, status: 200
        when "mobile"
            @buyer.update(
                phone_number: params[:mobile],
            )

            render json: {success: true}, status: 200
        end
    end
end
