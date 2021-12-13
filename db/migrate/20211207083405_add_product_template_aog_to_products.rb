class AddProductTemplateAogToProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :product_template_aog, null: false, foreign_key: true
  end
end
