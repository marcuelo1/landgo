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
            products: [],
            sellers: []
        }, status: 200
    end

    def is_signed_in
        render json: {success: true}, status: 200
    end

    def review_payment_location
        selected_payment_method = @buyer.selected_payment_method ? @buyer.selected_payment_method.id : PaymentMethod.find_by(name: "Cash").id

        order_summary = []
        seller_ids = params[:seller_ids].split(',')
        seller_ids.each do |si|
            seller = Seller.find(si)
            carts = @buyer.carts.where(seller_id: si)

            order_summary.push({seller: SellerBlueprint.render(seller), carts: CartBlueprint.render(carts)})
        end


        render json: {
            locations: LocationBlueprint.render(@locations), 
            payment_methods: PaymentMethodBlueprint.render(@payment_methods), 
            selected_payment_method: selected_payment_method,
            order_summary: order_summary
        }
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
