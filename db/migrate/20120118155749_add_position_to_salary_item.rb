class AddPositionToSalaryItem < ActiveRecord::Migration
  def change
    add_column :salary_items, :position, :integer
    add_index :salary_items, :position
  end
end
