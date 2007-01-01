class CreateBookings < ActiveRecord::Migration
  def self.up
    create_table :bookings do |t|
      t.column "title", :string, :limit => 100
      t.column "amount", :integer
      t.column "credit_account_id", :integer
      t.column "debit_account_id", :integer
      t.column "value_date", :datetime
    end
  end

  def self.down
    drop_table :bookings
  end
end
