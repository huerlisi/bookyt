class AddExchangeRateToBookings < ActiveRecord::Migration
  def self.up
    add_column :bookings, :exchange_rate, :float, :default => 1
  end

  def self.down
    remove_column :bookings, :exchange_rate
  end
end
