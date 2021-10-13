class RiderBlueprint < Blueprinter::Base
    fields :id, :first_name, :last_name, :email, :phone_number

    field :name do |r|
        r.name
    end
end