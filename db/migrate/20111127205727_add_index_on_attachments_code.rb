class AddIndexOnAttachmentsCode < ActiveRecord::Migration
  def up
    add_index :attachments, :code
  end

  def down
    remove_index :attachments, :code
  end
end
