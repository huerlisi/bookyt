class ChangeBookingsCommentsToText < ActiveRecord::Migration
  def self.up
    change_column :bookings, :comments, :text, :default => nil, :null => true
  end

  def self.down
    change_column :bookings, :comments, :string, :limit => 1000
  end
end
