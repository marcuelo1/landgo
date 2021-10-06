class VoucherBlueprint < Blueprinter::Base
    fields :id, :code, :description, :discount, :discount_type, :min_amount, :max_discount
end