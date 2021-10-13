class CreateWallets < ActiveRecord::Migration[6.0]
  def change
    create_table :wallets do |t|
      t.references :user, polymorphic: true, null: false
      t.float :amount

      t.timestamps
    end
  end
end
