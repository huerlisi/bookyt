require 'prawn/measurement_extensions'
# Unescape HTML
def html_unescape(value)
  # Return an empty string when value is nil.
  return '' unless value

  result = value

  result.gsub!(/<div>|<p>|<br>/, '')
  result.gsub!(/<\/div>|<\/p>|<\/br>|<br[ ]*\/>/, "\n")

  return result
end

prawn_document(:page_size => 'A4',  :top_margin => 60, :left_margin => 50, :right_margin => 55, :renderer => Prawn::LetterDocument, :template => "#{Rails.root}/data/templates/letter.pdf") do |pdf|
  receiver = @debit_invoice.customer
  sender = @debit_invoice.company

  # Header
  pdf.header(sender)

  pdf.move_down 60

  # Address
  pdf.indent 320 do
    pdf.full_address(receiver.vcard)
  end

  pdf.move_down 60

  # Place'n'Date
  pdf.indent 320 do
    pdf.text sender.vcard.locality + ", " + I18n.l(Date.today, :format => :long)
  end

  # Subject
  pdf.move_down 60
  pdf.text @debit_invoice.to_s, :style => :bold

  # Freetext
  pdf.text " "
  pdf.text html_unescape(@debit_invoice.text), :inline_format => true if @debit_invoice.present?
  pdf.text " "

  # Line Items
  pdf.text " "
  pdf.line_items_table(@debit_invoice, @debit_invoice.line_items)

  # Closing
  pdf.text " "
  pdf.closing(@debit_invoice.company, @debit_invoice.due_date)

  # Footer
  pdf.bounding_box [12 - pdf.bounds.absolute_left, 23 - pdf.bounds.absolute_bottom], :width => pdf.bounds.width do
    pdf.esr_recipe(@debit_invoice, BankAccount.find_by_code('1020'), sender)
  end
end
