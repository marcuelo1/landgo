class RiderController < ApiController
    before_action :authenticate_v1_rider!
    before_action :set_rider
    include RiderHelper

    private
    def set_rider
        @rider = current_v1_rider
    end
end
