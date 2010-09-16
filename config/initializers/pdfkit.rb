PDFKit.configure do |config|
#  config.wkhtmltopdf = '/usr/bin/wkhtmltopdf'
  config.default_options = {
    :page_size => 'A4',
    :print_media_type => true
  }
end
