class RenameAttachmentObjectToReference < ActiveRecord::Migration
  def up
    rename_column :attachments, :object_id, :reference_id
    rename_column :attachments, :object_type, :reference_type
  end

  def down
    rename_column :attachments, :reference_id, :object_id
    rename_column :attachments, :reference_type, :object_type
  end
end
