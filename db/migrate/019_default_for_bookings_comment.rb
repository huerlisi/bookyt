class DefaultForBookingsComment < ActiveRecord::Migration
  def self.up
    change_column_default :bookings, :comments, ''
  end

  def self.down
  end
end
