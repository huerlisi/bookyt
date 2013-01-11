class PortBookingImports < ActiveRecord::Migration
  def up
    Attachment.where(:type => 'BookingImport').update_all(:type => 'BookingImportAttachment', :encoding => 'ISO-8859-15')
  end
end
