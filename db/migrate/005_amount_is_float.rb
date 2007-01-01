class AmountIsFloat < ActiveRecord::Migration
  def self.up
    change_column "bookings", "amount", :float
  end

  def self.down
    change_column "bookings", "amount", :integer
  end
end
