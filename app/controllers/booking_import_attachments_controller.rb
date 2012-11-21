class BookingImportAttachmentsController < AttachmentsController
  defaults :resource_class => BookingImportAttachment

  def new
    resource.encoding = 'ISO-8859-15'

    new!
  end

  def create
    create! {
      new_booking_import_attachment_mt940_import_path(resource)
    }
  end
end
