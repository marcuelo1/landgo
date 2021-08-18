class SellerBlueprint < Blueprinter::Base
    fields :id, :name, :email, :phone_number, :address

    field :image do |seller|
        if seller.image.attached?
            Rails.application.routes.url_helpers.url_for( seller.image)
        else
            "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg"
        end
    end

    field :rating do |seller|
        seller.rating
    end
end