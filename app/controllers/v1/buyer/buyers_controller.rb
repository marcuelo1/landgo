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
            buyer: buyer_info(@buyer),
            categories: categories_info(@categories),
            selected_location: location_info(@buyer.selected_location),
            products: products_info(@buyer.recent_purchases),
            sellers: sellers_info(Seller.top_sellers)
        }, status: 200
    end

    def is_signed_in
        render json: {success: true}, status: 200
    end

    def review_payment_location
        render json: {
            locations: locations_info(@locations), 
            selected_location_id: @buyer.selected_location.id,
            payment_methods: payment_methods_info(@payment_methods), 
            selected_payment_method_id: @buyer.selected_payment_method.id,
        }
    end

    def product_details
        product = Product.find(params[:id])
        seller = product.seller

        render json: {
            sizes: sizes_and_prices_info(product.product_prices),
            add_on_groups: product_add_on_groups_info(product.product_add_ons),
            seller: seller_info(seller)
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
