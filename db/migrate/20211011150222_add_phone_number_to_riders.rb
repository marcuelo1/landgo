class AddPhoneNumberToRiders < ActiveRecord::Migration[6.0]
  def change
    add_column :riders, :phone_number, :string
  end
end
