class AddIsRequiredToTemplateAogs < ActiveRecord::Migration[6.0]
  def change
    add_column :template_aogs, :is_required, :boolean
    remove_column :template_aogs, :num_of_required
    add_column :template_aogs, :num_of_choices, :integer
  end
end
