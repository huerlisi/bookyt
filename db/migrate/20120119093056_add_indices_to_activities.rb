class AddIndicesToActivities < ActiveRecord::Migration
  def change
    # Activity
    add_index :activities, :date
    add_index :activities, :person_id
    add_index :activities, :project_id
    add_index :activities, :work_day_id

    # Project
    add_index :projects, :project_state_id
    add_index :projects, :client_id

    # WorkDay
    add_index :work_days, :person_id
    add_index :work_days, :date
  end
end
