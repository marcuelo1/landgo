class CartBlueprint < Blueprinter::Base
    fields :id, :quantity, :total

    field :product do |cart|
        ProductBlueprint.render(cart.product)
    end
    
    field :product_description do |cart|
        cart.product_description
    end
end