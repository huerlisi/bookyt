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

prawn_document(:renderer => Prawn::LetterDocument) do |pdf|
  receiver = @debit_invoice.customer
  sender = @debit_invoice.company

  # Header
  pdf.letter_header(sender, receiver, @debit_invoice.to_s)

  # Free text
  pdf.free_text(html_unescape(@debit_invoice.text)) if @debit_invoice.present?

  # Line Items
  pdf.line_items_table(@debit_invoice, @debit_invoice.line_items)

  # Closing
  pdf.invoice_closing(@debit_invoice.company, @debit_invoice.due_date)

  # Footer
  pdf.bounding_box [12 - pdf.bounds.absolute_left, 23 - pdf.bounds.absolute_bottom], :width => pdf.bounds.width do
    pdf.esr_recipe(@debit_invoice, BankAccount.find_by_code('1020'), sender, current_tenant.print_payment_for?)
  end
end
