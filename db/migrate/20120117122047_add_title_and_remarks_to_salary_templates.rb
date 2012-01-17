class AddTitleAndRemarksToSalaryTemplates < ActiveRecord::Migration
  def change
    add_column :salary_templates, :title, :string
    add_column :salary_templates, :remarks, :text
  end
end
