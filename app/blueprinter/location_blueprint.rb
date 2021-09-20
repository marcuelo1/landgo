class LocationBlueprint < Blueprinter::Base
    fields :id, :name, :latitude, :longitude, :details, :selected

    field :description do |location|
        location.address
    end
end