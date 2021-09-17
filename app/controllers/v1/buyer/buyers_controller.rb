class V1::Buyer::BuyersController < BuyerController
    # before_action :updateCurrentLocation, only: [:home_page, :list_of_stores]
    # before_action :set_location, only: [:home_page, :list_of_stores]
    
    def home_page
        # location
        @categories = Category.where.not(status: 0)

        render json: {
            buyer: BuyerBlueprint.render(@buyer),
            categories: CategoryBlueprint.render(@categories),
            products: [],
            sellers: []
        }, status: 200
    end

    def product_details
        product = Product.find(params[:id])

        render json: {
            sizes: ProductPriceBlueprint.render(product.product_prices),
            add_on_groups: AddOnGroupBlueprint.render(product.product_add_ons)
        }
    end

    def update
        case params[:update_type]
        when :name
            @buyer.update(
                first_name: params[:first_name],
                last_name: params[:last_name]
            )

            render json: {success: true}, status: 200
        when :email
            @buyer.update(
                email: params[:email],
            )

            render json: {success: true}, status: 200
        when :mobile
            @buyer.update(
                phone_number: params[:mobile],
            )

            render json: {success: true}, status: 200
        end
    end
end
