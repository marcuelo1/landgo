class V1::Buyer::CartsController < ApiController
    before_action :authenticate_v1_buyer!
    before_action :set_buyer

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
