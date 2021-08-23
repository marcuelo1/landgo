class ProductPriceBlueprint < Blueprinter::Base
    fields :id, :price

    field :size do |pp|
        pp.product_size.name
    end
end