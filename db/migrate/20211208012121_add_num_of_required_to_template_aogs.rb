class AddNumOfRequiredToTemplateAogs < ActiveRecord::Migration[6.0]
  def change
    add_column :template_aogs, :num_of_required, :integer
  end
end
