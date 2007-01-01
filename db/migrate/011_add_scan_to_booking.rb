class AddScanToBooking < ActiveRecord::Migration
  def self.up
    add_column :bookings, :scan, :string, :limit => 255
  end

  def self.down
    remove_column :bookings, :scan
  end
end
