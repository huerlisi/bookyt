class ChangeScaleForLineItemsTimes < ActiveRecord::Migration
  def up
    change_column :line_items, :times, :decimal, :precision => 10, :scale => 6
  end

  def down
  end
end
