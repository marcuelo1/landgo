class Admin::SellerController < AdministratorController
    before_action :set_categories, only: [:index, :new]
    before_action :set_sellers, only: [:index]
    # before_action :set_seller, :set_product_categories, :set_products, :set_product_sizes, :set_add_on_groups, :set_add_ons, only: [:show]

    def index
    end

    def new
    end
    

    def create
        seller = Seller.new(seller_params)
        @password = SecureRandom.hex(8)
        seller.password = @password
        seller.save

        geo_object = Geocoder.search([seller.latitude, seller.longitude]).first.data
        
        address = geo_object['address']
        seller.street = address['road'] ? address['road'] : ''
        seller.village = address['village'] ? address['village'] : address['suburb'] ? address['suburb'] : ''
        seller.city = address['city']
        seller.state = address['state'] ? address['state'] : address['region']

        seller.save

        redirect_to "/admin/seller"
    end

    def show
        @seller = Seller.find(params[:id])
        @products = @seller.products
        @product_categories = @seller.product_categories
        @add_on_groups = @seller.add_on_groups
        @add_ons = @seller.add_ons
        @product_templates = @seller.product_template_aogs
    end
    
    
    private
    def seller_params
        params.permit(:name, :email, :image, :phone_number, :category_id, :latitude, :longitude)
    end
    
    
end
