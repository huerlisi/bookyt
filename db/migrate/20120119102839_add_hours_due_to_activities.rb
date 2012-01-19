class AddHoursDueToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :hours_due, :decimal, :precision => 10, :scale => 2
  end
end
