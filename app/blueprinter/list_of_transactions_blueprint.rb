class ListOfTransactionsBlueprint < Blueprinter::Base
    fields :id, :status

    field :seller_name do |cs|
        cs.seller.name
    end

    field :seller_id do |cs|
        cs.seller.id
    end

    field :date do |cs|
        cs.updated_at
    end
end