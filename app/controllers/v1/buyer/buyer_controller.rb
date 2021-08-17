class V1::Buyer::BuyerController < ApplicationController
    before_action :authenticate_v1_buyer!
    before_action :set_buyer
    
    def home_page
        @categories = Category.where.not(status: 0)

        render json: {
            categories: CategoryBlueprint.render(@categories),
            products: [],
            sellers: []
        }, status: 200
    end

    def list_of_stores
        category = Category.find(params[:id])
        category_deals = category.category_deals 

        render json: {
            category_deals: category_deals,
        }
    end

    private
    def set_buyer
        @buyer = current_v1_buyer
    end
    
end
