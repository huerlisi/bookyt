class AddChargeIdToBookingTemplates < ActiveRecord::Migration
  def self.up
    add_column :booking_templates, :charge_rate_id, :integer
  end

  def self.down
    remove_column :booking_templates, :charge_rate_id
  end
end
