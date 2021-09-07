class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.references :user, polymorphic: true, null: false
      t.string :name
      t.float :longitude
      t.float :latitude
      t.string :details
      t.string :street
      t.string :city
      t.string :province

      t.timestamps
    end
  end
end
