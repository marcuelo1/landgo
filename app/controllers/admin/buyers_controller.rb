class Admin::BuyersController < AdministratorController
    def index
        @buyers = Buyer.all.order(first_name: :asc)
    end
end
