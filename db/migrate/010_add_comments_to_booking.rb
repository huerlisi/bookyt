class AddCommentsToBooking < ActiveRecord::Migration
  def self.up
    add_column :bookings, :comments, :string, :limit => 1000
  end

  def self.down
    remove_column :bookings, :comments
  end
end
