class RenameMt940AttachmentToBookingImportAttachment < ActiveRecord::Migration
  def up
    Attachment.where(:type => 'Mt940Attachment').update_all(:type => 'BookingImportAttachment')

    begin
      FileUtils.mv(Rails.root.join(AttachmentUploader.store_dir, 'mt940_attachment'), Rails.root.join(AttachmentUploader.store_dir, 'booking_import_attachment'))
    rescue
    end

    rename_column :mt940_imports, :mt940_attachment_id, :booking_import_attachment_id
  end
end
