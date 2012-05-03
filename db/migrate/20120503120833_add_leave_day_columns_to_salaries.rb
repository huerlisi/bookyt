# This migration comes from bookyt_salary (originally 20120503120833)
class AddLeaveDayColumnsToSalaries < ActiveRecord::Migration
  def change
    add_column :invoices, :leave_days_balance, :decimal, :precision => 4, :scale => 2
    add_column :invoices, :used_leave_days, :decimal, :precision => 4, :scale => 2
  end
end
