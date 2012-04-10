class DebitInvoiceDocument < LetterDocument
  include Prawn::EsrRecipe

  def invoice_closing(sender, due_date)
    text " "
    text I18n.t('letters.debit_invoice.closing', :due_date => due_date), :align => :justify

    text " "

    text I18n.t('letters.debit_invoice.greetings')
    text "#{sender.vcard.full_name}"
  end
end
