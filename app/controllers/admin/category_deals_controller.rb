class Admin::CategoryDealsController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_admin

    def create 
        cd = CategoryDeal.new(category_deal_params)
        cd.save 
        redirect_to "/admin/category/#{cd.category_id}"
    end

    private
    def category_deal_params
        params.permit(:name, :category_id, :image)
    end
    
end
