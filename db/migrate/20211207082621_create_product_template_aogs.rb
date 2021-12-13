class CreateProductTemplateAogs < ActiveRecord::Migration[6.0]
  def change
    create_table :product_template_aogs do |t|
      t.string :name
      t.references :seller, null: false, foreign_key: true

      t.timestamps
    end
  end
end
