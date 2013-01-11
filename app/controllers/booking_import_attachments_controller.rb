class BookingImportAttachmentsController < AttachmentsController
  defaults :resource_class => BookingImportAttachment

  def new
    resource.encoding = 'ISO-8859-15'
    resource.build_booking_import

    new!
  end

  def create
    create! {
      resource.booking_import
    }
  end
end
