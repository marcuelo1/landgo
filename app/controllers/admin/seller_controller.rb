class Admin::SellerController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_admin
    before_action :set_categories, only: [:index]
    before_action :set_sellers, only: [:index]

    def index
    end

    def create
        seller = Seller.new(seller_params)
        @password = SecureRandom.hex(8)
        seller.password = @password
        seller.save

        redirect_to "/admin/seller"
    end
    
    private
    def seller_params
        params.permit(:name, :email, :image, :phone_number, :category_id, :address)
    end
    
    
end
