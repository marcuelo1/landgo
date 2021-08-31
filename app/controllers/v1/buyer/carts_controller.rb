class V1::Buyer::CartsController < ApiController
    before_action :authenticate_v1_buyer!
    before_action :set_buyer

    def list_of_sellers
        seller_ids = Cart.where(buyer_id: @buyer.id).pluck(:seller_id).uniq
        @sellers = Seller.find(seller_ids)

        render json: {sellers: SellerBlueprint.render(@sellers)}, status: 200
    end
    

    def index
        @carts = Cart.where(buyer_id: @buyer.id, seller_id: params[:seller_id])

        render json: {
            carts: CartBlueprint.render(@carts)
        }
    end
    

    def create # add to cart
        @cart = Cart.new(cart_params)
        @cart.buyer_id = @buyer.id
        @cart.save 

        params[:add_on_ids].flatten.each do |aoi|
            CartAddOn.create(
                cart_id: @cart.id,
                add_on_id: aoi
            )
        end

        render json: {success: true}, status: 200
    end
    
    private
    def cart_params
        params.permit(:product_id, :seller_id, :quantity, :product_price_id, :total)
    end
end
