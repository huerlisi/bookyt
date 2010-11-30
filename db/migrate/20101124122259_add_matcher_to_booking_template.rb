class AddMatcherToBookingTemplate < ActiveRecord::Migration
  def self.up
    add_column :booking_templates, :matcher, :string
  end

  def self.down
    remove_column :booking_templates, :matcher
  end
end
