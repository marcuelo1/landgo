class CheckoutProductBlueprint < Blueprinter::Base
    fields :id, :quantity, :total, :description

    field :name do |cp|
        cp.product.name
    end
end