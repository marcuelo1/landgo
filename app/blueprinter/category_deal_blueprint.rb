class CategoryDealBlueprint < Blueprinter::Base
    fields :id, :name

    field :image do |cd|
        if cd.image.attached?
            Rails.application.routes.url_helpers.url_for( cd.image)
        else
            "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg"
        end
    end
end