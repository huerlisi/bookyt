class AddMissingSalaryIndices < ActiveRecord::Migration
  def change
    # SalaryTemplate
    add_index :salary_templates, :person_id
  end
end
