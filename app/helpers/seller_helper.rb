module SellerHelper

    def seller_info seller
        {
            id: seller.id,
            name: seller.name,
            email: seller.email,
            phone_number: seller.phone_number,
            rating: seller.rating,
            address: seller.location.address,
            image: seller.image.attached? ? Rails.application.routes.url_helpers.url_for(seller.image) : no_image()
        }
    end

    def transaction_details css
        css.collect do |cs|
            transaction_detail(cs)
        end
    end

    def transaction_detail cs
        order = cs.checkout_products.collect do |cp|
            {
                product_id: cp.product_id,
                name: cp.product.name,
                quantity: cp.quantity,
                size: cp.product_price.product_size.name,
                add_ons: cp.add_ons.pluck(:name)
            }
        end 

        return {
            id: cs.id,
            total: cs.subtotal,
            status: cs.status,
            created_at: cs.created_at,
            updated_at: cs.updated_at,
            products: order
        }
    end
end
