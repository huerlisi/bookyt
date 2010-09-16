class DueDateShallBeADate < ActiveRecord::Migration
  def self.up
    change_column :invoices, :due_date, :date
  end

  def self.down
    change_column :invoices, :due_date, :integer
  end
end
