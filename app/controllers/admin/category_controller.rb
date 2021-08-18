class Admin::CategoryController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_admin
    before_action :set_categories, only: [:index]

    def index
    end
    
    def create
        category = Category.new(categogry_params)
        category.status = 0

        category.save 
        redirect_to "/admin/category"
    end

    def show
        @category = Category.find(params[:id])
    end
    
    
    private
    def categogry_params
        params.permit(:name, :image)
    end
    
end
