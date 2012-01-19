class ChangeMaterializedColumnsInWorkDays < ActiveRecord::Migration
  def up
    add_column :work_days, :hours_due, :decimal, :precision => 10, :scale => 2
    add_column :work_days, :hours_worked, :decimal, :precision => 10, :scale => 2

    remove_column :work_days, :daily_workload
  end
end
