class V1::Seller::TransactionsController < SellerController
    def pending
        checkout_sellers
    end
end