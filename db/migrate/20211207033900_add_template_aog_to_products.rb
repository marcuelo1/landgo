class AddTemplateAogToProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :template_aog, null: false, foreign_key: true
  end
end
