class AddEncodingToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :encoding, :string
  end
end
