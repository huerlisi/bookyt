class AddTypeToBookingTemplates < ActiveRecord::Migration
  def self.up
    add_column :booking_templates, :type, :string
  end

  def self.down
    remove_column :booking_templates, :type
  end
end
