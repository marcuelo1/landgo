class RemoveSellerFromTemplateAog < ActiveRecord::Migration[6.0]
  def change
    remove_reference :template_aogs, :seller, null: false, foreign_key: true
    remove_column :template_aogs, :name
  end
end
