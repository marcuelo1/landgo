class V1::Buyer::CheckoutsController < BuyerController
    before_action :set_checkout, only: [:create]

    def create
        seller_ids = params[:sellers]
        seller_ids.each do |si|
            @checkout_seller = CheckoutSeller.new(checkout_id: @checkout.id, seller_id: si, delivery_fee: 0, total: 0)
            if @checkout_seller.save 
                # get carts of buyer
                carts = @buyer.carts.where(seller_id: si) 
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
            else
                @checkout.destroy
                return render json: {success: false, message: @checkout_seller.errors}, status: 500
            end
        end
        return render json: {success: true, checkout_id: @checkout.id}, status: 200
    end
end
