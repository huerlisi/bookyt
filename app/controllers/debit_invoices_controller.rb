class DebitInvoicesController < InvoicesController
  # Actions
  def new
    # Allow pre-seeding some parameters
    invoice_params = {
      :company_id => current_tenant.company.id,
      :value_date => Date.today,
      :due_date   => Date.today.in(30.days).to_date,
      :title      => "Rechnung " + Date.today.strftime('%B')
    }

    # Set default parameters
    invoice_params.merge!(params[:invoice]) if params[:invoice]

    @debit_invoice = DebitInvoice.new(invoice_params)

    @debit_invoice.line_items.build(
      :times         => 1,
      :quantity      => 'x',
      :vat_rate_code => 'vat:full',
      :contra_account => DebitInvoice.default_contra_account
    )

    if current_tenant.vat_number.present?
      @debit_invoice.line_items.build(
        :title          => 'MWSt.',
        :times          => 0.08,
        :quantity       => '%',
        :contra_account => Account.find_by_code('2206')
      )
    end

    # Prebuild an empty attachment instance
    @debit_invoice.attachments.build

    new!
  end

  def create
    invoice_params = {
      :state      => 'booked'
    }

    invoice_params.merge!(params[:debit_invoice]) if params[:debit_invoice]

    @debit_invoice = DebitInvoice.new(invoice_params)
    @debit_invoice.build_booking

    create!
  end
end
