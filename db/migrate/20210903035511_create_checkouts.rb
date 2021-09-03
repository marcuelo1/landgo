class CreateCheckouts < ActiveRecord::Migration[6.0]
  def change
    create_table :checkouts do |t|
      t.references :buyer, null: false, foreign_key: true
      t.integer :status
      t.float :total

      t.timestamps
    end
  end
end
