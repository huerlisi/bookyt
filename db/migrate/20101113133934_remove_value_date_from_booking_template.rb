class RemoveValueDateFromBookingTemplate < ActiveRecord::Migration
  def self.up
    remove_column :booking_templates, :value_date
  end

  def self.down
    add_column :booking_templates, :value_date, :date
  end
end
