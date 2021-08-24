class AddOnGroupBlueprint < Blueprinter::Base
    fields :id, :name 

    field :add_ons do |aog|
        aog.add_ons.collect do |ao|
            {
                price: ao.price,
                name: ao.name
            }
        end
    end
end