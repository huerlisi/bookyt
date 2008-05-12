class AddCurrencySupportToBookings < ActiveRecord::Migration
  def self.up
    add_column :bookings, :debit_currency, :string, :default => 'CHF'
    add_column :bookings, :credit_currency, :string, :default => 'CHF'

    Booking.find(:all).each do |booking|
      booking.debit_currency = 'CHF'
      booking.credit_currency = 'CHF'
    end
  end

  def self.down
    remove_column :bookings, :debit_currency
    remove_column :bookings, :credit_currency
  end
end
