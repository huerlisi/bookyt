class RenameDurationColumnsInProjectsAndActivities < ActiveRecord::Migration
  def change
    rename_column :activities, :when, :date
    rename_column :activities, :from, :duration_from
    rename_column :activities, :to, :duration_to

    rename_column :projects, :from, :duration_from
    rename_column :projects, :to, :duration_to
  end
end
