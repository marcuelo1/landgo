class RemoveUserFromLocation < ActiveRecord::Migration[6.0]
  def change
    remove_reference :locations, :user, polymorphic: true, null: false
  end
end
