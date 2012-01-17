class RenameSalaryBookingTemplateHabtmTable < ActiveRecord::Migration
  def up
    rename_table :salary_templates_salary_booking_templates, :salary_booking_templates_salary_templates
  end
end
