# This migration comes from has_accounts (originally 20161018190258)
class UseDecimalForBookingCode < ActiveRecord::Migration
  def up
    change_column :bookings, :code, :decimal, :scale => 0, :precision => 100
  end

  def down
    change_column :bookings, :code, :integer
  end
end
