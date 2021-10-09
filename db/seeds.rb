# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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
        product_sizes: ['Small', 'Medium', 'Large'],
        add_on_groups: ['Add a dessert'],
        add_ons: [
            {
                name: 'Large Sundae',
                price: 50,
                add_on_group_name: 'Add a dessert'

            }
        ],
        products: [
            {
                name: "Chicken burger",
                product_category_name: 'Burger',
                image: "chicken_burger.jpg",
                description: 'Best chicken buerge ever',
                product_prices: [
                    {
                        size: 'Small',
                        price: 45
                    },
                    {
                        size: 'Medium',
                        price: 65
                    },
                    {
                        size: 'Large',
                        price: 85
                    },
                ],
                product_add_ons: [
                    {
                        name: 'Add a dessert',
                        require: 1,
                        num_of_select: 1
                    }
                ]
            },
            {
                name: "Coke",
                product_category_name: 'Drinks',
                image: "coke.jpg",
                description: 'Best soft drinks ever',
                product_prices: [
                    {
                        size: 'Small',
                        price: 25
                    },
                    {
                        size: 'Medium',
                        price: 35
                    },
                    {
                        size: 'Large',
                        price: 45
                    },
                ],
                product_add_ons: [
                    {
                        name: 'Add a dessert',
                        require: 1,
                        num_of_select: 1
                    }
                ]
            },
            {
                name: "Sundae",
                product_category_name: 'Desserts',
                image: "sundae.jpg",
                description: 'Best dessert ever',
                product_prices: [
                    {
                        size: 'No Size',
                        price: 25
                    },
                ],
                product_add_ons: []
            }
        ]
    },
    {
        name: "Jollibee Test",
        email: "test2@gmail.com",
        phone_number: "09214895941",
        category_id: Category.find_by(name: "Food").id,
        address: "Lacson st., Bacolod City",
        image: 'jollibee.png',
        product_categories: ['Burger', 'Drinks', 'Desserts'],
        product_sizes: ['Small', 'Medium', 'Large'],
        add_on_groups: ['Add a dessert'],
        add_ons: [
            {
                name: 'Large Sundae',
                price: 50,
                add_on_group_name: 'Add a dessert'

            }
        ],
        products: [
            {
                name: "Chicken burger",
                product_category_name: 'Burger',
                image: "chicken_burger.jpg",
                description: 'Best chicken buerge ever',
                product_prices: [
                    {
                        size: 'Small',
                        price: 45
                    },
                    {
                        size: 'Medium',
                        price: 65
                    },
                    {
                        size: 'Large',
                        price: 85
                    },
                ],
                product_add_ons: [
                    {
                        name: 'Add a dessert',
                        require: 1,
                        num_of_select: 1
                    }
                ]
            },
            {
                name: "Coke",
                product_category_name: 'Drinks',
                image: "coke.jpg",
                description: 'Best soft drinks ever',
                product_prices: [
                    {
                        size: 'Small',
                        price: 25
                    },
                    {
                        size: 'Medium',
                        price: 35
                    },
                    {
                        size: 'Large',
                        price: 45
                    },
                ],
                product_add_ons: [
                    {
                        name: 'Add a dessert',
                        require: 1,
                        num_of_select: 1
                    }
                ]
            },
            {
                name: "Sundae",
                product_category_name: 'Desserts',
                image: "sundae.jpg",
                description: 'Best dessert ever',
                product_prices: [
                    {
                        size: 'No Size',
                        price: 25
                    },
                ],
                product_add_ons: []
            }
        ]
    },
    {
        name: "KFC Test",
        email: "test3@gmail.com",
        phone_number: "09288264736",
        category_id: Category.find_by(name: "Food").id,
        address: "Lacson st., Bacolod City",
        image: 'kfc.jpg',
        product_categories: ['Burger', 'Drinks', 'Desserts'],
        product_sizes: ['Small', 'Medium', 'Large'],
        add_on_groups: ['Add a dessert'],
        add_ons: [
            {
                name: 'Large Sundae',
                price: 50,
                add_on_group_name: 'Add a dessert'

            }
        ],
        products: [
            {
                name: "Chicken burger",
                product_category_name: 'Burger',
                image: "chicken_burger.jpg",
                description: 'Best chicken buerge ever',
                product_prices: [
                    {
                        size: 'Small',
                        price: 45
                    },
                    {
                        size: 'Medium',
                        price: 65
                    },
                    {
                        size: 'Large',
                        price: 85
                    },
                ],
                product_add_ons: [
                    {
                        name: 'Add a dessert',
                        require: 1,
                        num_of_select: 1
                    }
                ]
            },
            {
                name: "Coke",
                product_category_name: 'Drinks',
                image: "coke.jpg",
                description: 'Best soft drinks ever',
                product_prices: [
                    {
                        size: 'Small',
                        price: 25
                    },
                    {
                        size: 'Medium',
                        price: 35
                    },
                    {
                        size: 'Large',
                        price: 45
                    },
                ],
                product_add_ons: [
                    {
                        name: 'Add a dessert',
                        require: 1,
                        num_of_select: 1
                    }
                ]
            },
            {
                name: "Sundae",
                product_category_name: 'Desserts',
                image: "sundae.jpg",
                description: 'Best dessert ever',
                product_prices: [
                    {
                        size: 'No Size',
                        price: 25
                    },
                ],
                product_add_ons: []
            }
        ]
    },
    {
        name: "Greenwich Test",
        email: "test4@gmail.com",
        phone_number: "09171058588",
        category_id: Category.find_by(name: "Food").id,
        address: "Lacson st., Bacolod City",
        image: 'greenwich.jpg',
        product_categories: ['Burger', 'Drinks', 'Desserts'],
        product_sizes: ['Small', 'Medium', 'Large'],
        add_on_groups: ['Add a dessert'],
        add_ons: [
            {
                name: 'Large Sundae',
                price: 50,
                add_on_group_name: 'Add a dessert'

            }
        ],
        products: [
            {
                name: "Chicken burger",
                product_category_name: 'Burger',
                image: "chicken_burger.jpg",
                description: 'Best chicken buerge ever',
                product_prices: [
                    {
                        size: 'Small',
                        price: 45
                    },
                    {
                        size: 'Medium',
                        price: 65
                    },
                    {
                        size: 'Large',
                        price: 85
                    },
                ],
                product_add_ons: [
                    {
                        name: 'Add a dessert',
                        require: 1,
                        num_of_select: 1
                    }
                ]
            },
            {
                name: "Coke",
                product_category_name: 'Drinks',
                image: "coke.jpg",
                description: 'Best soft drinks ever',
                product_prices: [
                    {
                        size: 'Small',
                        price: 25
                    },
                    {
                        size: 'Medium',
                        price: 35
                    },
                    {
                        size: 'Large',
                        price: 45
                    },
                ],
                product_add_ons: [
                    {
                        name: 'Add a dessert',
                        require: 1,
                        num_of_select: 1
                    }
                ]
            },
            {
                name: "Sundae",
                product_category_name: 'Desserts',
                image: "sundae.jpg",
                description: 'Best dessert ever',
                product_prices: [
                    {
                        size: 'No Size',
                        price: 25
                    },
                ],
                product_add_ons: []
            }
        ]
    },
    {
        name: "Sbarro Test",
        email: "test5@gmail.com",
        phone_number: "09123456789",
        category_id: Category.find_by(name: "Food").id,
        address: "Lacson st., Bacolod City",
        image: 'sbarro.jpg',
        product_categories: ['Burger', 'Drinks', 'Desserts'],
        product_sizes: ['Small', 'Medium', 'Large'],
        add_on_groups: ['Add a dessert'],
        add_ons: [
            {
                name: 'Large Sundae',
                price: 50,
                add_on_group_name: 'Add a dessert'

            }
        ],
        products: [
            {
                name: "Chicken burger",
                product_category_name: 'Burger',
                image: "chicken_burger.jpg",
                description: 'Best chicken buerge ever',
                product_prices: [
                    {
                        size: 'Small',
                        price: 45
                    },
                    {
                        size: 'Medium',
                        price: 65
                    },
                    {
                        size: 'Large',
                        price: 85
                    },
                ],
                product_add_ons: [
                    {
                        name: 'Add a dessert',
                        require: 1,
                        num_of_select: 1
                    }
                ]
            },
            {
                name: "Coke",
                product_category_name: 'Drinks',
                image: "coke.jpg",
                description: 'Best soft drinks ever',
                product_prices: [
                    {
                        size: 'Small',
                        price: 25
                    },
                    {
                        size: 'Medium',
                        price: 35
                    },
                    {
                        size: 'Large',
                        price: 45
                    },
                ],
                product_add_ons: [
                    {
                        name: 'Add a dessert',
                        require: 1,
                        num_of_select: 1
                    }
                ]
            },
            {
                name: "Sundae",
                product_category_name: 'Desserts',
                image: "sundae.jpg",
                description: 'Best dessert ever',
                product_prices: [
                    {
                        size: 'No Size',
                        price: 25
                    },
                ],
                product_add_ons: []
            }
        ]
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

        # create product size of No Size
        ProductSize.create(seller_id: seller.id, name: "No Size")

        # create product categories
        s[:product_categories].each do |pcs|
            ProductCategory.create(name: pcs, seller_id: seller.id)
        end

        # create product sizes
        s[:product_sizes].each do |ps|
            ProductSize.create(name: ps, seller_id: seller.id)
        end

        # create product add on groups
        s[:add_on_groups].each do |aog|
            AddOnGroup.create(name: aog, seller_id: seller.id)
        end

        # create product add ons
        s[:add_ons].each do |ao|
            AddOn.create(
                name: ao[:name], 
                price: ao[:price], 
                add_on_group_id: AddOnGroup.find_by(name: ao[:add_on_group_name], seller_id: seller.id).id
            )
        end

        # create products
        s[:products].each do |pr|
            product = Product.create(
                name: pr[:name], 
                product_category_id: ProductCategory.find_by(name: pr[:product_category_name], seller_id: seller.id).id, 
                description: pr[:description],
                seller_id: seller.id
            )

            file = File.open(File.join(Rails.root,"app/assets/images/products/#{pr[:image]}"))
            filename = pr[:image]
            product.image.attach(io: file, filename: filename)

            pr[:product_prices].each do |pp|
                ProductPrice.create(
                    product_id: product.id,
                    price: pp[:price],
                    base_price: pp[:price],
                    product_size_id: ProductSize.find_by(name: pp[:size], seller_id: seller.id).id
                )
            end

            pr[:product_add_ons].each do |pao|
                ProductAddOn.create(
                    product_id: product.id,
                    add_on_group_id: AddOnGroup.find_by(name: pao[:name], seller_id: seller.id).id,
                    require: pao[:require],
                    num_of_select: pao[:num_of_select]
                )
            end
        end
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