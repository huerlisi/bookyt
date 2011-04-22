class AddObjectRelationToAttachments < ActiveRecord::Migration
  def self.up
    add_column :attachments, :object_id, :integer
    add_column :attachments, :object_type, :string
  end

  def self.down
    remove_column :attachments, :object_type
    remove_column :attachments, :object_id
  end
end
