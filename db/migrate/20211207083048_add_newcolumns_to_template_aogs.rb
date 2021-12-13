class AddNewcolumnsToTemplateAogs < ActiveRecord::Migration[6.0]
  def change
    add_reference :template_aogs, :product_template_aog, null: false, foreign_key: true
    add_reference :template_aogs, :add_on_group, null: false, foreign_key: true
  end
end
