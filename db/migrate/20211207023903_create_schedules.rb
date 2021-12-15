class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.references :seller, null: false, foreign_key: true
      t.string :monday_start
      t.string :monday_end
      t.string :tuesday_start
      t.string :tuesday_end
      t.string :wednesday_start
      t.string :wednesday_end
      t.string :thursday_start
      t.string :thursday_end
      t.string :friday_start
      t.string :friday_end
      t.string :saturday_start
      t.string :saturday_end
      t.string :sunday_start
      t.string :sunday_end

      t.timestamps
    end
  end
end
