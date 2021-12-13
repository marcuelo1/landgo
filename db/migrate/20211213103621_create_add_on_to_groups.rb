class CreateAddOnToGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :add_on_to_groups do |t|
      t.references :add_on_group, null: false, foreign_key: true
      t.references :add_on, null: false, foreign_key: true

      t.timestamps
    end
  end
end
