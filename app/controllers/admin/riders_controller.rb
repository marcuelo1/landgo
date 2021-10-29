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

        # create location for rider
        Location.create(user_id: @rider.id, user_type: @rider.class.to_s)

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
