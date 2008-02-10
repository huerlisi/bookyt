class ChangeValueDateToDateOnly < ActiveRecord::Migration
  def self.up
    change_column :bookings, :value_date, :date
  end

  def self.down
    change_column :bookings, :value_date, :datetime
  end
end
