class AddActivitiesToWorkDay < ActiveRecord::Migration
  def change
    add_column :activities, :work_day_id, :integer
  end
end
