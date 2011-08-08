prawn_document(:page_size => 'A4',  :top_margin => 60, :right_margin => 40, :renderer => Prawn::LetterDocument) do |pdf|
  receiver = @debit_invoice.customer
  sender = @debit_invoice.company

  pdf.header(sender)

  pdf.move_down 80

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
  pdf.text @debit_invoice.to_s, :style => :bold

  # Line Items
  pdf.text " "
  pdf.line_items_table(@debit_invoice, @debit_invoice.line_items)

  # Closing
  pdf.text " "
  pdf.closing(@debit_invoice.company)
end
