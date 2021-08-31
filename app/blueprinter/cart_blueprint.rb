class CartBlueprint < Blueprinter::Base
    fields :quantity, :total

    field :cart_id do |cart|
        cart.id
    end

    field :product do |cart|
        ProductBlueprint.render(cart.product)
    end
    
    field :product_description do |cart|
        cart.product_description
    end
end