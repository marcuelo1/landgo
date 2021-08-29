class AddOnGroupBlueprint < Blueprinter::Base
    fields :require

    field :id do |pao|
        pao.add_on_group.id
    end
    
    field :name do |pao|
        pao.add_on_group.name
    end

    field :add_ons do |pao|
        pao.add_on_group.add_ons.collect do |ao|
            {
                price: ao.price,
                name: ao.name,
                id: ao.id,
                add_on_group_id: ao.add_on_group_id
            }
        end
    end
end