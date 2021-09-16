class LocationBlueprint < Blueprinter::Base
    fields :id, :name, :latitude, :longitude, :details

    field :description do |location|
        location.address
    end
end