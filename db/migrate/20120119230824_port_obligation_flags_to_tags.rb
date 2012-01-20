class PortObligationFlagsToTags < ActiveRecord::Migration
  def up
    # Setup tags based on db flags
    SalaryBookingTemplate.find_each do |template|
      template.include_in_saldo_list = SalaryBookingTemplate.saldo_inclusion_flags.collect do |flag|
        flag if template["for_#{flag}"]
      end

      template.save
    end

    remove_column :booking_templates, :for_gross_income
    remove_column :booking_templates, :for_ahv
    remove_column :booking_templates, :for_uvg
    remove_column :booking_templates, :for_uvgz
    remove_column :booking_templates, :for_ktg
    remove_column :booking_templates, :for_deduction_at_source
  end
end
