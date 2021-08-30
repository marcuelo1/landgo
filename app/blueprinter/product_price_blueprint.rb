class ProductPriceBlueprint < Blueprinter::Base
    fields :price

    field :product_price_id do |pp|
        pp.id
    end

    field :size do |pp|
        pp.product_size.name
    end
end