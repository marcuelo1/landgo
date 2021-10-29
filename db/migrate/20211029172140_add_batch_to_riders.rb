class AddBatchToRiders < ActiveRecord::Migration[6.0]
  def change
    add_reference :riders, :batch, null: true, foreign_key: true
  end
end
