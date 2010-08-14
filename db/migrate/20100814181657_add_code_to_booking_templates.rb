class AddCodeToBookingTemplates < ActiveRecord::Migration
  def self.up
    add_column :booking_templates, :code, :string
  end

  def self.down
    remove_column :booking_templates, :code
  end
end
