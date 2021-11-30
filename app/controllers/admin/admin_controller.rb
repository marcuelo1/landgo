class Admin::AdminController < AdministratorController
    
    def index
        @checkout_sellers = CheckoutSeller.where.not(enqueued_time: nil).order(:enqueued_time)
    end

    def refind_available_rider
        checkout_seller = CheckoutSeller.find(params[:checkout_seller_id])
        seller = checkout_seller.seller
        FindAvailableRiderJob.perform_later(seller.location.latitude, seller.location.longitude, checkout_seller)

        return render json: {success: true}, status: 200
    end
    
end
