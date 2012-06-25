class AddTypeToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :type, :string
    Attachment.update_all(:type => 'Attachment')
  end
end
