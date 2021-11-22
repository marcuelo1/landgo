module ApplicationHelper
    def date_form_format date
        "#{date['day']}/#{date['month']}/#{date['year']}".to_datetime
    end

    def formated_datetime datetime
        datetime.strftime("%b %d, %Y")
    end

    def get_voucher_discount(subtotal, voucher)
        voucher_discount = 0
        if voucher
            if voucher.discount_type == "Percent"
                voucher_discount = subtotal * (voucher.discount / 100)

                voucher_discount = voucher_discount < voucher.max_discount ? voucher_discount : voucher.max_discount
            else
                voucher_discount = voucher.discount
            end
        end

        return voucher_discount
    end

    def get_vat subtotal
        subtotal * 0.2 * 0.12
    end

    def get_address(latitude, longitude)
        geo_object = Geocoder.search([latitude, longitude]).first.data
        
        address = geo_object['address']
        street = address['road'] ? address['road'] : ''
        village = address['village'] ? address['village'] : address['suburb'] ? address['suburb'] : ''
        city = address['city']
        
        buyer_address = [street, village, city]
        buyer_address.delete('')
        
        return buyer_address.join(', ')
    end

    def no_image
        "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg"
    end

    def rider_info(rider)
        {
            id: rider.id,
            email: rider.email,
            first_name: rider.first_name,
            last_name: rider.last_name,
            phone_number: rider.phone_number,
            name: rider.name,
            status: rider.status_int,
        }
    end

    def buyer_info buyer
        {
            id: buyer.id,
            first_name: buyer.first_name,
            last_name: buyer.last_name,
            email: buyer.email,
            phone_number: buyer.phone_number,
            name: buyer.name
        }
    end

    def categories_info categories
        categories.collect do |category|
            category_info(category)
        end
    end

    def category_info category
        {
            id: category.id,
            name: category.name,
            status: category.status,
            image: category.image.attached? ? Rails.application.routes.url_helpers.url_for(category.image) : no_image()
        }
    end

    def locations_info locations
        locations.collect do |location|
            location_info(location)
        end
    end

    def location_info location
        {
            id: location.id,
            name: location.name,
            latitude: location.latitude,
            longitude: location.longitude,
            details: location.details,
            selected: location.selected,
            description: location.address
        }
    end

    def products_info products
        products.collect do |product|
            product_info(product)
        end
    end

    def product_info product
        {
            id: product.id,
            name: product.name,
            description: product.description,
            product_category_id: product.product_category_id,
            price: product.product_prices.first.price,
            base_price: product.product_prices.first.base_price,
            image: product.image.attached? ? Rails.application.routes.url_helpers.url_for(product.image) : no_image()
        }
    end

    def sellers_info sellers
        sellers.collect do |seller|
            seller_info(seller)
        end
    end

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

    def payment_methods_info pms
        pms.collect do |pm|
            payment_method_info(pm)
        end
    end

    def payment_method_info pm
        {
            id: pm.id,
            name: pm.name
        }
    end

    def sizes_and_prices_info product_prices
        product_prices.collect do |pp|
            size_and_price_info(pp)
        end
    end

    def size_and_price_info product_price 
        {
            product_price_id: product_price.id,
            price: product_price.price,
            base_price: product_price.base_price,
            size: product_price.product_size.name
        }
    end

    def product_add_on_groups_info paogs
        paogs.collect do |paog|
            product_add_on_group_info(paog)
        end
    end

    def product_add_on_group_info paog
        add_on_group = paog.add_on_group 
        add_ons = add_on_group.add_ons
        add_ons = add_ons.collect do |ao|
            add_on_info(ao)
        end

        return {
            id: add_on_group.id,
            name: add_on_group.name,
            require: paog.require,
            num_of_select: paog.num_of_select,
            add_ons: add_ons
        }
    end

    def add_on_info add_on 
        {
            id: add_on.id,
            price: add_on.price,
            name: add_on.name,
            add_on_group_id: add_on.add_on_group_id
        }
    end

    def vouchers_info vouchers
        vouchers.collect do |v|
            voucher_info(v)
        end
    end

    def voucher_info voucher
        {
            id: voucher.id, 
            code: voucher.code, 
            description: voucher.description, 
            discount: voucher.discount,
            discount_type: voucher.discount_type,
            min_amount: voucher.min_amount, 
            max_discount: voucher.max_discount
        }
    end

    def carts_info carts
        carts.collect do |c|
            cart_info(c)
        end
    end

    def cart_info cart
        {
            id: cart.id,
            quantity: cart.quantity,
            total: cart.total,
            product_description: cart.product_description,
            product: product_info(cart.product)
        }
    end

    def product_categories_info pcs
        pcs.collect do |pc|
            product_category_info(pc)
        end
    end

    def product_category_info pc
        {
            id: pc.id,
            name: pc.name
        }
    end

    def checkout_sellers_info css
        css.collect do |cs|
            checkout_seller_info(cs)
        end
    end
    
    def checkout_seller_info cs
        seller = cs.seller 

        return {
            id: cs.id,
            status: cs.status,
            seller_id: seller.id,
            seller_name: seller.name,
            date: cs.updated_at
        }
    end

    def checkout_products_info cps 
        cps.collect do |cp|
            checkout_product_info(cp)
        end
    end

    def checkout_product_info cp
        {
            id: cp.id,
            quantity: cp.quantity,
            total: cp.total,
            description: cp.description,
            name: cp.product.name
        }
    end
    
    def broadcast(channel, data)
        ActionCable.server.broadcast(channel, data)
    end
end
