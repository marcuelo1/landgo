class CreateVouchers < ActiveRecord::Migration[6.0]
  def change
    create_table :vouchers do |t|
      t.string :code
      t.string :description
      t.float :discount
      t.string :discount_type
      t.float :min_amount
      t.float :max_discount
      t.datetime :valid_from
      t.datetime :valid_until

      t.timestamps
    end
  end
end
