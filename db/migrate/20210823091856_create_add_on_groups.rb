class CreateAddOnGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :add_on_groups do |t|
      t.string :name
      t.references :seller, null: false, foreign_key: true

      t.timestamps
    end
  end
end
