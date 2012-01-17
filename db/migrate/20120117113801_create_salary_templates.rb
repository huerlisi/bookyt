class CreateSalaryTemplates < ActiveRecord::Migration
  def change
    create_table :salary_templates do |t|
      t.integer :person_id

      t.timestamps
    end
  end
end
