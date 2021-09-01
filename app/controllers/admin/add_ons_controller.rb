class Admin::AddOnsController < AdministratorController
    before_action :set_seller, :set_add_on_groups, only: [:new]

    def create
        ao = AddOn.new(add_on_params)
        ao.save 

        redirect_to "/admin/seller/#{ao.add_on_group.seller_id}"
    end

    def new
        
    end
    
    private
    def add_on_params
        params.permit(:name, :price, :add_on_group_id)
    end
end
