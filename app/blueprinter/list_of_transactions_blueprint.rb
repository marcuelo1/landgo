class ListOfTransactionsBlueprint < Blueprinter::Base
    fields :id, :total

    field :seller_name do |cs|
        cs.seller.name
    end

    field :products_names do |cs|
        product_ids = cs.checkout_products.pluck(:product_id)
        Product.find(product_ids).pluck(:name).join(',')
    end

    field :date do |cs|
        cs.updated_at
    end
end