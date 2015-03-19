class BookingImportAttachment < Attachment
  # Booking Import
  has_one :booking_import
  accepts_nested_attributes_for :booking_import

  def content
    File.read(file.current_path, :encoding => self.encoding).encode(universal_newline: true)
  end
end
