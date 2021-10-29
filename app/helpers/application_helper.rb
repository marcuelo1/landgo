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

    def rider_info(rider)
        {
            id: rider.id,
            email: rider.email,
            first_name: rider.first_name,
            last_name: rider.last_name,
            phone_number: rider.phone_number,
            name: rider.name,
        }
    end
end
