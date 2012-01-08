class AddSalarySpecificFlagsToBookingTemplates < ActiveRecord::Migration
  def change
    add_column :booking_templates, :for_gross_income, :boolean
    add_column :booking_templates, :for_ahv, :boolean
    add_column :booking_templates, :for_uvg, :boolean
    add_column :booking_templates, :for_uvgz, :boolean
    add_column :booking_templates, :for_ktg, :boolean
    add_column :booking_templates, :for_deduction_at_source, :boolean
    add_column :booking_templates, :salary_declaration_code, :integer
  end
end
