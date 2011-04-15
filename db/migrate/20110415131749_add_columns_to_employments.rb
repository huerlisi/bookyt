class AddColumnsToEmployments < ActiveRecord::Migration
  def self.up
    add_column :employments, :remarks, :text
    add_column :employments, :salary_amount, :decimal
    add_column :employments, :kids, :integer
    add_column :employments, :workload, :decimal
  end

  def self.down
    remove_column :employments, :workload
    remove_column :employments, :kids
    remove_column :employments, :salary_amount
    remove_column :employments, :remarks
  end
end
