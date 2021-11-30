class Admin::AdminController < AdministratorController
    
    def index
        @checkout_sellers = CheckoutSeller.where.not(enqueued_time: nil).order(:enqueued_time)
    end
    
end
