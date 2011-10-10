class RenameTaskToActivity < ActiveRecord::Migration
  def change
    rename_table :tasks, :activities
  end
end
