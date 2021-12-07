class CreateCartAddOns < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_add_ons do |t|
      t.references :add_on, null: false, foreign_key: true

      t.timestamps
    end
  end
end
