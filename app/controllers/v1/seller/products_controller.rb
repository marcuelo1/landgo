class V1::Seller::ProductsController < SellerController
    def index
        seller = Seller.find(params[:seller_id])
        products = seller.products

        
    end
end