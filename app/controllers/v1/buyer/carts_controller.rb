class V1::Buyer::CartsController < BuyerController

    def list_of_sellers
        seller_ids = Cart.where(buyer_id: @buyer.id).pluck(:seller_id).uniq
        @sellers = Seller.find(seller_ids)
        @vouchers = @buyer.vouchers
        delivery_fees = {}
        @sellers.map{|s| delivery_fees[s.id] = s.delivery_fee(@buyer)}

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

        add_ons_total = 0
        params[:add_on_ids].flatten.each do |aoi|
            add_on = AddOn.find(aoi)
            add_ons_total += add_on.price

            CartAddOn.create(
                cart_id: @cart.id,
                add_on_id: add_on.id
            )
        end

        product_price = @cart.product_price.price
        single_item_price = product_price + add_ons_total
        total = single_item_price * @cart.quantity

        @cart.update(single_item_price: single_item_price, total: total)

        render json: {success: true}, status: 200
    end

    def update
        case params[:type]
        when "quantity"
            @cart = Cart.find(params[:id])
            if params[:quantity].to_i > 0
                total = params[:quantity].to_i * @cart.single_item_price
                @cart.update(quantity: params[:quantity], total: total)
            else
                @cart.destroy
            end

            return render json: {success: true, total: @cart.total}, status: 200
        else
            
        end

        render json: {success: true}, status: 200
    end
    
    private
    def cart_params
        params.permit(:product_id, :seller_id, :quantity, :product_price_id)
    end
end
