class V1::Buyer::CartsController < BuyerController

    def list_of_sellers
        seller_ids = Cart.where(buyer_id: @buyer.id).pluck(:seller_id).uniq
        @sellers = Seller.find(seller_ids)
        @vouchers = @buyer.vouchers
        delivery_fees = @sellers.map{|s| s.delivery_fee(@buyer)}

        render json: {
            sellers: SellerBlueprint.render(@sellers),
            vouchers: VoucherBlueprint.render(@vouchers),
            delivery_fees: delivery_fees
        }, status: 200
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

    def update
        @cart = Cart.find(params[:id])

        @cart.update(quantity: params[:quantity], total: params[:total])

        render json: {success: true}, status: 200
    end
    
    private
    def cart_params
        params.permit(:product_id, :seller_id, :quantity, :product_price_id, :total)
    end
end
