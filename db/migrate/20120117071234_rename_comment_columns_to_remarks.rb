class RenameCommentColumnsToRemarks < ActiveRecord::Migration
  def up
    rename_column :projects, :comment, :remarks
    rename_column :activities, :comment, :remarks

    change_column :activities, :remarks, :text
  end

  def down
    change_column :activities, :remarks, :string

    rename_column :projects, :remarks, :comment
    rename_column :activities, :remarks, :comment
  end
end
