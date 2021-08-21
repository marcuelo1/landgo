class ProductBlueprint < Blueprinter::Base
    fields :id, :name, :product_category_id

    field :image do |product|
        if product.image.attached?
            Rails.application.routes.url_helpers.url_for( product.image)
        else
            "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg"
        end
    end

    field :price do |product|
        100.0
    end
end