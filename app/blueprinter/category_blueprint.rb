class CategoryBlueprint < Blueprinter::Base
    fields :id, :name, :status

    field :image do |category|
        if category.image.attached?
            Rails.application.routes.url_helpers.url_for( category.image)
        else
            "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg"
        end
    end
end