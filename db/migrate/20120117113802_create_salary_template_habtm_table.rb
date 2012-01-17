class CreateSalaryTemplateHabtmTable < ActiveRecord::Migration
  def up
    create_table "salary_templates_salary_booking_templates", :id => false do |t|
      t.integer "salary_template_id"
      t.integer "salary_booking_template_id"
    end
  end

  def down
    drop_table "salary_templates_salary_booking_templates"
  end
end
