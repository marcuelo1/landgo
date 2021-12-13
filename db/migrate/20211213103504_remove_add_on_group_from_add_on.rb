class RemoveAddOnGroupFromAddOn < ActiveRecord::Migration[6.0]
  def change
    remove_reference :add_ons, :add_on_group, null: false, foreign_key: true
  end
end
