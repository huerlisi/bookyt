class CreditInvoicesController < InvoicesController
  defaults :resource_class => CreditInvoice

  # Actions
  def new
    # Allow pre-seeding some parameters
    invoice_params = {
      :customer_id => current_tenant.company.id,
      :state       => 'booked',
      :value_date  => Date.today,
      :due_date    => Date.today.in(30.days).to_date
    }

    # Set default parameters
    invoice_params.merge!(params[:invoice]) if params[:invoice]

    @credit_invoice = CreditInvoice.new(invoice_params)

    @credit_invoice.line_items.build(
      :times         => 1,
      :quantity      => 'x',
      :vat_rate_code => 'vat:full',
      :contra_account => CreditInvoice.default_contra_account
    )

    # Prebuild an empty attachment instance
    @credit_invoice.attachments.build

    new!
  end

  def create
    @credit_invoice = CreditInvoice.new(params[:credit_invoice])
    @credit_invoice.build_booking

    create!
  end

  def copy
    super

    @debit_invoice = @invoice
  end
end
