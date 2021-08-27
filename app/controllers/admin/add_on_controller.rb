class Admin::AddOnController < AdministratorController

    def create
        ao = AddOn.new(add_on_params)
        ao.save 

        redirect_to "/admin/seller/#{ao.add_on_group.seller_id}"
    end

    def group_create
        aog = AddOnGroup.new(add_on_group_params)
        aog.save 

        redirect_to "/admin/seller/#{params[:seller_id]}"
    end
    
    private
    def add_on_params
        params.permit(:name, :price, :add_on_group_id)
    end
    
    def add_on_group_params
        params.permit(:seller_id, :name)
    end
end
