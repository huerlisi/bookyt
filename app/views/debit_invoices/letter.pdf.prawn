prawn_document(:page_size => 'A4',  :top_margin => 160, :right_margin => 40, :renderer => Prawn::LetterDocument) do |pdf|
  receiver = @debit_invoice.customer
  sender = @debit_invoice.customer

  pdf.header(@debit_invoice.company)

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
  pdf.text t('activerecord.models.invoice'), :style => :bold

  # Line Items
  pdf.text " "
  pdf.line_items_table(@debit_invoice, @debit_invoice.line_items)

  # Closing
  pdf.text " "
  pdf.closing(@debit_invoice.company)
end
