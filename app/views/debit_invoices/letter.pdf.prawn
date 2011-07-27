prawn_document(:page_size => 'A4',  :top_margin => 150, :renderer => Prawn::LetterDocument) do |pdf|
  pdf.letter_head(@debit_invoice.company, @debit_invoice.customer)

  pdf.header(@debit_invoice.company)
end
