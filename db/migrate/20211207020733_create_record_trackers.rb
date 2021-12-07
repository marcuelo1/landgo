class CreateRecordTrackers < ActiveRecord::Migration[6.0]
  def change
    create_table :record_trackers do |t|
      t.references :seller, null: false, foreign_key: true
      t.references :object, polymorphic: true, null: false
      t.string :attribute
      t.string :old_data
      t.string :new_Data
      t.integer :status
      t.datetime :approved_date
      t.datetime :declined_date
      t.string :declined_reason

      t.timestamps
    end
  end
end
