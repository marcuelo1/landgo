class Admin::AddOnGroupsController < AdministratorController
    before_action :set_seller, only: [:new]

    def new
        
    end

    def create
        aog = AddOnGroup.new(add_on_group_params)
        aog.save!

        redirect_to "/admin/seller/#{params[:seller_id]}"
    end
    
    private
    def add_on_group_params
        params.permit(:seller_id, :name, :title)
    end
end
