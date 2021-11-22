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

    def products_info products
        products.collect do |p|
            product_info(p)
        end
    end

    def product_info product
        sizes = product.product_prices.collect do |pp|
            {
                name: pp.product_size.name,
                price: pp.price,
                base_price: pp.base_price
            }
        end

        add_on_groups = product.product_add_ons.collect do |pao|
            add_on_group = pao.add_on_group
            
            {
                id: add_on_group.id,
                name: add_on_group.name,
                require: pao.require,
                num_of_select: pao.num_of_select,
                add_ons: add_on_group.add_ons.map{|ao| {id: ao.id, name: ao.name, price: ao.price} }
            }
        end

        return {
            id: product.id,
            name: product.name,
            product_category_name: product.product_category.name,
            description: product.description,
            image: product.image.attached? ? Rails.application.routes.url_helpers.url_for(product.image) : no_image(),
            sizes: sizes,
            add_on_groups: add_on_groups
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
