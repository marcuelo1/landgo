class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.references :seller, null: false, foreign_key: true
      t.datetime :monday_start
      t.datetime :monday_end
      t.datetime :tuesday_start
      t.datetime :tuesday_end
      t.datetime :wednesday_start
      t.datetime :wednesday_end
      t.datetime :thursday_start
      t.datetime :thursday_end
      t.datetime :friday_start
      t.datetime :friday_end
      t.datetime :saturday_start
      t.datetime :saturday_end
      t.datetime :sunday_start
      t.datetime :sunday_end

      t.timestamps
    end
  end
end
