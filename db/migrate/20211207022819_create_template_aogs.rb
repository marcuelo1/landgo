class CreateTemplateAogs < ActiveRecord::Migration[6.0]
  def change
    create_table :template_aogs do |t|
      t.references :seller, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
