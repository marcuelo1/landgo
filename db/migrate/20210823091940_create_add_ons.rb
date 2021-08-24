class CreateAddOns < ActiveRecord::Migration[6.0]
  def change
    create_table :add_ons do |t|
      t.float :price
      t.string :name
      t.references :add_on_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
