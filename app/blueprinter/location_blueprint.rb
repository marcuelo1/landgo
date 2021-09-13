class LocationBlueprint < Blueprinter::Base
    fields :id, :name, :latitude, :longitude

    field :details do |location|
        location.address
    end
end