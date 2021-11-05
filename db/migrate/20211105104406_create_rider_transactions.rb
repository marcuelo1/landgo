class CreateRiderTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :rider_transactions do |t|
      t.references :rider, null: false, foreign_key: true
      t.references :checkout_seller, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
