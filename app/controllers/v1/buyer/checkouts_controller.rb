class V1::Buyer::CheckoutsController < BuyerController
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
        seller_ids = params[:sellers]
        seller_ids.each do |si|
            @checkout_seller = CheckoutSeller.new(checkout_id: @checkout.id, seller_id: si, delivery_fee: 0, total: 0)
            if @checkout_seller.save 
                # get carts of buyer
                carts = @buyer.carts.where(seller_id: si) 
                checkout_seller_price = 0
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
                        total: cart.total
                    )

                    checkout_seller_price += cart.total

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

                @checkout_seller.update(total: checkout_seller_price)
            else
                @checkout.destroy
                return render json: {success: false, message: @checkout_seller.errors}, status: 500
            end
        end
        return render json: {success: true, checkout_id: @checkout.id}, status: 200
    end

    def show
        checkout_seller = @buyer.checkout_sellers.find_by(seller_id: params[:id])
        checkout = checkout_seller.checkout
        seller = checkout_seller.seller
        carts = @buyer.carts.where(seller_id: seller.id)
        geo_object = Geocoder.search([checkout.latitude, checkout.longitude]).first.data
        
        address = geo_object['address']
        street = address['road'] ? address['road'] : ''
        village = address['village'] ? address['village'] : address['suburb'] ? address['suburb'] : ''
        city = address['city']
        
        buyer_address = [street, village, city]
        buyer_address.delete('')
        buyer_address = buyer_address.join(', ')

        render json: {
            seller: SellerBlueprint.render(seller), 
            carts: CartBlueprint.render(carts),
            buyer_address: buyer_address
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
        sellers = @buyer.checkout_sellers.where(status: 0)

        render json: {sellers: ListOfTransactionsBlueprint.render(sellers)}, status: 200
    end
end
