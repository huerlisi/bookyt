class UseDecimalForActivityDuration < ActiveRecord::Migration
  def up
    remove_column :activities, :duration
    add_column :activities, :duration, :decimal, :scale => 2, :precision => 4
  end

  def down
  end
end
