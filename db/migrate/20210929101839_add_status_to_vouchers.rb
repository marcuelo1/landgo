class AddStatusToVouchers < ActiveRecord::Migration[6.0]
  def change
    add_column :vouchers, :status, :integer
  end
end
