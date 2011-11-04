class AddCodeToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :code, :string
  end
end
