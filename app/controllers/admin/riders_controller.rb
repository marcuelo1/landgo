class Admin::RidersController < AdministratorController

    def index
        @riders = Rider.all
    end

    def new
        @rider = Rider.new()
    end

    def create
        @rider = Rider.new(rider_params)
        # @password = SecureRandom.hex(8)
        @rider.password = "marcuelo2"
        @rider.save

        redirect_to "/admin/riders"
    end

    def show
        @rider = Rider.find(params[:id])
    end

    private
    def rider_params
        params.require(:rider).permit(:first_name, :last_name, :email, :phone_number)
    end
end
