class V1::Buyer::SearchController < BuyerController
    def suggestion_words
        words = PgSearch::Document.where('LOWER(content) LIKE ?', "#{params[:keyword].downcase}%").order(:content).pluck(:content).uniq.take(5)

        render json: {suggested_words: words}, status: 200
    end

    def index
        sellers = Seller.seller_search(params[:keyword])

        render json: {sellers: SellerBlueprint.render(sellers)}, status: 200
    end
end
