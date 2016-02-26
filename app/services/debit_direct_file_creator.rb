class DebitDirectFileCreator
  ESR_REFERENCE = 'A'

  attr_reader :tenant, :bank_account, :ids

  def self.call(tenant, bank_account, ids = nil)
    new(tenant, bank_account, ids).call
  end

  def initialize(tenant, bank_account, ids = nil)
    @tenant = tenant
    @bank_account = bank_account
    @ids = ids
  end

  def call
    DebitDirectFile.create content: content, debit_invoice_ids: debit_invoices.pluck(:id)
  end

  def debit_invoices
    return @debit_invoices if @debit_invoices
    @debit_invoices = DebitInvoice.
                        invoice_state(:booked).
                        joins(:customer).
                        where(:debit_direct_file_id => nil).
                        where(:people => { :direct_debit_enabled => true })
    @debit_invoices = @debit_invoices.where(id: ids) if ids
    @debit_invoices
  end

  def content
    debit_invoices.each do |invoice|
      file.add_record lsv_record(invoice)
    end
    file.to_s
  end

  def file
    @file ||= LSVplus::File.new file_attributes
  end

  def file_attributes
    {
      :creator_identification => tenant.debit_direct_identification,
      :currency => 'CHF',
      :processing_type => 'P',
      :creation_date => Date.today,
      :lsv_identification => tenant.debit_direct_identification,
    }
  end

  def lsv_record(invoice)
    LSVplus::Record.new(
      :processing_date => processing_date,
      :creditor_bank_clearing_number => creditor_bank_clearing_number,
      :amount => amount(invoice),
      :debitor_bank_clearing_number => debitor_bank_clearing_number(invoice),
      :creditor_iban => creditor_iban,
      :creditor_address => address(tenant.company),
      :debitor_account => debitor_account(invoice),
      :debitor_address => address(invoice.customer),
      :message => message(invoice),
      :reference_type => ESR_REFERENCE,
      :reference => reference(invoice),
      :esr_member_id => esr_member_id,
    )
  end

  def processing_date
    Date.tomorrow
  end

  def creditor_bank_clearing_number
    bank_account.bank.clearing
  end

  def amount(invoice)
    invoice.amount
  end

  def debitor_bank_clearing_number(invoice)
    invoice.customer.clearing
  end

  def creditor_iban
    bank_account.iban
  end

  def address(contact)
    [
      contact.vcard.full_name,
      contact.vcard.street_address,
      "#{contact.vcard.postal_code} #{contact.vcard.locality}"
    ]
  end

  def debitor_account(invoice)
    invoice.customer.bank_account
  end

  def reference(invoice)
    esr_number = VESR::ReferenceBuilder.call(invoice.customer.id, invoice.id, bank_account.esr_id)
    VESR::ValidationDigitCalculator.call(esr_number)
  end

  def message(invoice)
    invoice.title
  end

  def esr_member_id
    bank_account.esr_id
  end
end
