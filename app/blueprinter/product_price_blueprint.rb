class ProductPriceBlueprint < Blueprinter::Base
    fields :price, :base_price

    field :product_price_id do |pp|
        pp.id
    end

    field :size do |pp|
        pp.product_size.name
    end
end