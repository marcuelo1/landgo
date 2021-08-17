class CreateCategoryDeals < ActiveRecord::Migration[6.0]
  def change
    create_table :category_deals do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
