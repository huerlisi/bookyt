class DebitInvoicePDF
  def initialize(invoice, tenant)
    @invoice = invoice
    @tenant = tenant
  end

  def filename
    "#{DebitInvoice.model_name.human} #{@invoice.long_ident}.pdf"
  end

  def call
    receiver = @invoice.customer
    sender = @invoice.company
    bank_account = DebitInvoice.payment_account

    # Header
    pdf.letter_header(sender, receiver, @invoice.to_s, @invoice.value_date)

    # Period
    pdf.period(@invoice.duration_from.to_s, @invoice.duration_to.to_s)
    pdf.text I18n.t('pdf.debit_invoice.due', date: @invoice.due_date.to_s)
    pdf.text I18n.t('pdf.debit_invoice.invoice_number', number: @invoice.code)

    # Line Items
    pdf.line_items_table(@invoice, @invoice.line_items)

    # If we do not use the vesr part, we have some space and can make
    # the invoice look cleaner
    unless @tenant.use_vesr?
      pdf.text "\n" * 5
    end

    # Free text
    pdf.free_text(@invoice.text)

    case
    when @invoice.customer.direct_debit_enabled?
      pdf.free_text I18n.t('pdf.debit_invoice.lsv_message')
    when bank_account.bank
      pdf.footer(sender, bank_account, @tenant.vat_number, @tenant.uid_number, @tenant.use_vesr?)
    end

    if @tenant.use_vesr? && !@invoice.customer.direct_debit_enabled?
      pdf.draw_esr(@invoice, bank_account, sender, @tenant.print_payment_for?)
    end

    pdf.render
  end

  def pdf
    @pdf ||= DebitInvoiceDocument.new
  end
end
