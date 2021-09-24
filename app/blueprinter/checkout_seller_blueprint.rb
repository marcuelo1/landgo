class CheckoutSellerBlueprint < Blueprinter::Base
    fields :id, :total, :delivery_fee, :status

    field :seller_name do |cs|
        
    end
end