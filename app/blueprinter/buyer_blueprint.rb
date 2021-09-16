class BuyerBlueprint < Blueprinter::Base
    fields :id, :first_name, :last_name, :email, :phone_number

    field :name do |buyer|
        buyer.name
    end
end