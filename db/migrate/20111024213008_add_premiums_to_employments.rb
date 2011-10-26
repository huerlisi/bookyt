class AddPremiumsToEmployments < ActiveRecord::Migration
  def change
    add_column :employments, :overtime_premium, :decimal
    add_column :employments, :holiday_premium, :decimal
    add_column :employments, :sunday_premium, :decimal
    add_column :employments, :night_premium, :decimal
  end
end
