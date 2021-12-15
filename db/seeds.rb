###########################################################################################################
############ ADMIN
###########################################################################################################
if Admin.find_by(email: "admin@gmail.com") == nil
    Admin.create(
        email: "admin@gmail.com",
        password: "admin123",
        first_name: "super",
        last_name: "admin"
    )
end
###########################################################################################################
############ CATEGORIES
###########################################################################################################
categories = [
    {
        name: "Food",
        image: "food.jpg"
    },
    {
        name: "Grocery",
        image: "grocery.jpg"
    },
    {
        name: "Pharmacy",
        image: "pharmacy.jpeg"
    },
    {
        name: "Hardware",
        image: "hardware.jpg"
    },
]

if Category.all.count == 0
    categories.each do |c|
        file = File.open(File.join(Rails.root,"app/assets/images/categories/#{c[:image]}")) if c[:image].present?
        filename = c[:image] if c[:image].present?
        if file
            c = Category.create(name: c[:name], status: 0)
            c.image.attach(io: file, filename: filename)
        end
    end

    Category.first.update(status: 2)
end
###########################################################################################################
############ SELLERS
###########################################################################################################
sellers = [
    # Food Category
    {
        name: "Mcdonalds Test",
        email: "test1@gmail.com",
        phone_number: "09053536495",
        category_id: Category.find_by(name: "Food").id,
        address: "Lacson st., Bacolod City",
        image: 'mcdo.jpg',
        product_categories: ['Burger', 'Drinks', 'Desserts'],
        add_on_groups: [
            {name: "aog1 required=false and any number of choices", title: "Please pick a dessert", is_required: false, num_of_choices: 0},
            {name: "aog2 required=true 1 needed", title: "Please pick a side", is_required: true, num_of_choices: 1},
            {name: "aog3 required=false upto 3 choices", title: "Please pick a side 2", is_required: false, num_of_choices: 3},
        ],
        add_ons: [
            {name: 'Large Sundae', price: 100},
            {name: 'Regular Sundae', price: 75},
            {name: 'Large Fries', price: 50},
            {name: 'Regular Fries', price: 25},
        ],
        product_template_aogs: ['pta_1', 'pta_2', 'pta_3'],
        products: [
            {
                name: "Chicken burger",
                product_category_name: 'Burger',
                image: "chicken_burger.jpg",
                description: 'Best chicken buerge ever',
                product_sizes: [
                    {name: 'Small', price: 45},
                    {name: 'Medium', price: 65},
                    {name: 'Large', price: 85},
                ],
                product_template_aog: 'pta_1'
            },
            {
                name: "Coke",
                product_category_name: 'Drinks',
                image: "coke.jpg",
                description: 'Best soft drinks ever',
                product_sizes: [
                    {name: 'Small', price: 25},
                    {name: 'Medium', price: 35},
                    {name: 'Large', price: 45},
                ],
                product_template_aog: 'pta_2'
            },
            {
                name: "Sundae",
                product_category_name: 'Desserts',
                image: "sundae.jpg",
                description: 'Best dessert ever',
                product_sizes: [
                    {name: 'Small', price: 30},
                    {name: 'Medium', price: 60},
                    {name: 'Large', price: 90},
                ],
                product_template_aog: 'pta_3'
            }
        ],
        location: {
            latitude: 10.6580222,
            longitude: 122.9410383
        }
    },
]
if Seller.count == 0
    sellers.each do |s|
        seller = Seller.create(
            name: s[:name],
            email: s[:email],
            phone_number: s[:phone_number],
            category_id: s[:category_id],
            address: s[:address]
        )
        @password = SecureRandom.hex(8)
        seller.password = @password
        seller.save

        file = File.open(File.join(Rails.root,"app/assets/images/sellers/#{s[:image]}")) if s[:image].present?
        filename = s[:image] if s[:image].present?
        seller.image.attach(io: file, filename: filename)

        # create add ons
        s[:add_ons].each do |ao|
            AddOn.create(
                name: ao[:name], 
                price: ao[:price], 
                seller_id: seller.id
            )
        end

        # create add on groups 
        s[:add_on_groups].each do |aog|
            add_on_group = AddOnGroup.create(
                name: aog[:name],
                title: aog[:title],
                seller_id: seller.id
            )

            # connect add ons to add on group
            AddOn.where(seller_id: seller.id).each do |ao|
                AddOnToGroup.create(add_on_group_id: add_on_group.id, add_on_id: ao.id)
            end
        end

        # create product template add on group
        s[:product_template_aogs].each do |name|
            pta = ProductTemplateAog.create(name: name, seller_id: seller.id)

            # create template add on group
            s[:add_on_groups].each do |aog_raw|
                aog = AddOnGroup.where(seller_id: seller.id, name: aog_raw[:name]).first
                TemplateAog.create(
                    product_template_aog_id: pta.id,
                    add_on_group_id: aog.id,
                    is_required: aog_raw[:is_required],
                    num_of_choices: aog_raw[:num_of_choices]
                )
            end
        end

        # create product categories
        s[:product_categories].each do |pcs|
            ProductCategory.create(name: pcs, seller_id: seller.id)
        end

        # create products
        s[:products].each do |pr|
            product = Product.create(
                name: pr[:name], 
                product_category_id: ProductCategory.find_by(name: pr[:product_category_name], seller_id: seller.id, 
                description: pr[:description],
                seller_id: seller.id
            )

            file = File.open(File.join(Rails.root,"app/assets/images/products/#{pr[:image]}"))
            filename = pr[:image]
            product.image.attach(io: file, filename: filename)

            pr[:product_sizes].each do |ps|
                ProductSize.create(
                    name: ps[:name],
                    product_id: product.id,
                    price: pp[:price]
                )
            end
            
            pta = ProductTemplateAog.where(name: pr[:product_template_aog], seller_id: seller.id).first
            product.update(product_template_aog_id: pta.id)
        end

        # create location
        geo_object = Geocoder.search([s[:location][:latitude], s[:location][:longitude]]).first.data

        address = geo_object['address']
        print(address)
        
        seller.update(
            longitude: s[:location][:longitude], 
            latitude: s[:location][:latitude],
            details: "GF room 101",
            street: address['road'],
            village: address['village'] ? address['village'] : address['suburb'],
            city: address['city'],
            state: address['state']
        )

        # create schedule
        Schedule.create(
            seller_id: seller.id,
            monday_start: "8:00:AM",
            monday_end: "5:30:PM",
            tuesday_start: "8:00:AM",
            tuesday_end: "5:30:PM",
            wednesday_start: "8:00:AM",
            wednesday_end: "5:30:PM",
            thursday_start: "8:00:AM",
            thursday_end: "5:30:PM",
            friday_start: "8:00:AM",
            friday_end: "5:30:PM",
            saturay_start: "8:00:AM",
            saturday_end: "5:30:PM",
            sunday_start: "8:00:AM",
            sunday_end: "5:30:PM",
        )
    end
end
###########################################################################################################
############ VOUCHERS
###########################################################################################################
vouchers = [
    {
        code: 'TESTVOUCHER1',
        description: 'test voucher 1',
        discount: 60,
        discount_type: 'Percent',
        min_amount: 20,
        max_discount: 100,
        valid_from: DateTime.now,
        valid_until: DateTime.now + 1.months,
        status: 1,
    },
    {
        code: 'TESTVOUCHER2',
        description: 'test voucher 2',
        discount: 60,
        discount_type: 'Amount',
        min_amount: 20,
        max_discount: nil,
        valid_from: DateTime.now,
        valid_until: DateTime.now + 1.months,
        status: 1,
    },
]

if Voucher.all.count == 0
    vouchers.each do |v|
        Voucher.create(v)
    end
end
###########################################################################################################
############ PAYMENT METHODS
###########################################################################################################
if PaymentMethod.all.count == 0
    PaymentMethod.create(name: "Cash")
end
###########################################################################################################
############ BATCH
###########################################################################################################
if Batch.all.count == 0
    Batch.create(name: "Batch 1", acceptance_rate: 90.0)
    Batch.create(name: "Batch 2", acceptance_rate: 70.0)
    Batch.create(name: "Batch 3", acceptance_rate: 60.0)
    Batch.create(name: "Batch 4", acceptance_rate: 50.0)
end
###########################################################################################################
############ BUYER
###########################################################################################################
if Buyer.all.count == 0
    buyer = Buyer.create(
        email: "test1@gmail.com",
        password: "marcuelo2",
        first_name: "Paul Brian",
        last_name: "Marcuelo",
        phone_number: "09053536495"
    )

    # create location
    latitude = 10.6636045
    longitude = 122.9414224
    geo_object = Geocoder.search([latitude, longitude]).first.data
    location = Location.new(
        user_id: buyer.id,
        user_type: "Buyer",
        longitude: longitude, 
        latitude: latitude
    )
    
    address = geo_object['address']
    print(address)
    location.street = address['road']
    location.village = address['village'] ? address['village'] : address['suburb']
    location.city = address['city']
    location.state = address['state']
    location.details = "Lot 3, Block 2"
    location.name = "Home"
    location.save
end
###########################################################################################################
############ RIDER
###########################################################################################################
if Rider.all.count == 0
    rider = Rider.create(
        email: "test1@gmail.com",
        password: "marcuelo2",
        first_name: "Paul Brian",
        last_name: "Marcuelo",
        phone_number: "09053536495",
        batch_id: Batch.first.id,
    )

    Location.create(
        user_type: "Rider",
        user_id: rider.id,
        name: "",
        longitude: 122.9414224,
        latitude: 10.6636045,
    )

    rider = Rider.create(
        email: "test2@gmail.com",
        password: "marcuelo2",
        first_name: "Paul Brian",
        last_name: "Marcuelo",
        phone_number: "09012336495",
        batch_id: Batch.first.id,
    )

    Location.create(
        user_type: "Rider",
        user_id: rider.id,
        name: "",
        longitude: 122.9414224,
        latitude: 10.6636045,
    )
end