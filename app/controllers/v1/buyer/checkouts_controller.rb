class V1::Buyer::CheckoutsController < BuyerController
    include ApplicationHelper
    before_action :set_checkout, only: [:create]

    def index
        completed_sellers = @buyer.checkout_sellers.where(status: 3)
        canceled_sellers = @buyer.checkout_sellers.where(status: 4)

        render json: {
            completed: ListOfTransactionsBlueprint.render(completed_sellers), 
            canceled: ListOfTransactionsBlueprint.render(canceled_sellers)
        }, status: 200
    end

    def create
        sellers = params[:sellers]
        vouchers = params[:selectedVouchers]
        delivery_fees = params[:deliveryFees]
        
        sellers.each do |seller|
            seller = Seller.find(seller[:id])
            voucher = Voucher.find_by(id: vouchers.map{|v| v['seller_id'] == seller.id ? v['voucher']['id'] : []}.flatten.first)

            # find available rider
            rider = find_available_rider(seller.location.latitude, seller.location.longitude)
            
            @checkout_seller = CheckoutSeller.new(
                checkout_id: @checkout.id, 
                seller_id: seller.id, 
                delivery_fee: delivery_fees["#{seller.id}"], 
                voucher_id: voucher ? voucher.id : nil,
                rider_id: rider.id
            )

            if @checkout_seller.save 
                # get carts of buyer
                carts = @buyer.carts.where(seller_id: seller.id) 
                subtotal = 0

                carts.each do |cart|
                    product = cart.product 
                    product_price = cart.product_price 
                    product_size = product_price.product_size 

                    @checkout_product = CheckoutProduct.new(
                        checkout_seller_id: @checkout_seller.id,
                        product_id: product.id,
                        product_price_id: product_price.id,
                        size: product_size.name,
                        price: product_price.price,
                        quantity: cart.quantity,
                        description: cart.product_description,
                        total: cart.total
                    )

                    subtotal += cart.total

                    if @checkout_product.save
                        # get cart product's add ons
                        cart.cart_add_ons.each do |cao|
                            add_on = cao.add_on
                            @checkout_add_on = CheckoutAddOn.new(
                                checkout_product_id: @checkout_product.id,
                                add_on_id: add_on.id,
                                name: add_on.name,
                                price:add_on.price
                            )
                            if !@checkout_add_on.save
                                @checkout.destroy
                                return render json: {success: false, message: @checkout_add_on.errors}, status: 500
                            end
                        end
                    else
                        @checkout.destroy
                        return render json: {success: false, message: @checkout_product.errors}, status: 500
                    end
                end

                voucher_discount = get_voucher_discount(subtotal, voucher)
                vat = get_vat(subtotal)
                
                total = subtotal + @checkout_seller.delivery_fee + vat - voucher_discount
                @checkout_seller.update(subtotal: subtotal, total: total, vat: vat)

                @buyer.carts.where(seller_id: seller.id).destroy_all
                
                # websocket to rider
                # websocket to seller

                return render json: {success: true, checkout_id: @checkout.id}, status: 200
            else
                @checkout.destroy
                return render json: {success: false, message: @checkout_seller.errors}, status: 500
            end
        end
    end

    def show
        checkout_seller = @buyer.checkout_sellers.find_by(seller_id: params[:id])
        checkout = checkout_seller.checkout
        seller = checkout_seller.seller
        checkout_products = checkout_seller.checkout_products
        buyer_address = get_address(checkout.latitude, checkout.longitude)

        render json: {
            checkout_products: CheckoutProductBlueprint.render(checkout_products),
            buyer_address: buyer_address,
            delivery_fee: checkout_seller.delivery_fee,
            subtotal: checkout_seller.subtotal,
            total: checkout_seller.total,
            vat: checkout_seller.vat,
            voucher_discount: get_voucher_discount(checkout_seller.subtotal, checkout_seller.voucher)
        }, status: 200
        
    end

    def update
        checkout_seller = @buyer.checkout_sellers.find_by(seller_id: params[:id])
        if checkout_seller.update(status: params[:status].to_i)
            render json: {success: true}, status: 200
        else
            render json: {success: false}, status: 500
        end
    end

    def current_transactions
        checkout_sellers = @buyer.checkout_sellers.where(status: 0)

        render json: {checkout_sellers: ListOfTransactionsBlueprint.render(checkout_sellers)}, status: 200
    end
end
