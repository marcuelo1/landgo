class CreateDiscountTrackers < ActiveRecord::Migration[6.0]
  def change
    create_table :discount_trackers do |t|
      t.references :seller, null: false, foreign_key: true
      t.integer :discount_type
      t.float :discount_amount
      t.string :products_id
      t.float :min_amount
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
