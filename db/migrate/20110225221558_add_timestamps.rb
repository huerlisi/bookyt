class AddTimestamps < ActiveRecord::Migration
  def self.up
    add_timestamps :account_types
    add_timestamps :accounts
    add_timestamps :addresses
    add_timestamps :bookings
    add_timestamps :phone_numbers
    add_timestamps :vcards
  end

  def self.down
  end
end
