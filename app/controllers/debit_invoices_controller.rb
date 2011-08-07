class DebitInvoicesController < InvoicesController
  # Actions
  def new
    # Allow pre-seeding some parameters
    invoice_params = {
      :company_id => current_tenant.company.id,
      :state      => 'booked',
      :value_date => Date.today,
      :due_date   => Date.today.in(30.days).to_date
    }

    # Set default parameters
    invoice_params.merge!(params[:invoice]) if params[:invoice]

    @debit_invoice = DebitInvoice.new(invoice_params)

    @debit_invoice.line_items.build(
      :quantity => 1,
      :price    => @debit_invoice.amount
    )

    # Prebuild an empty attachment instance
    @debit_invoice.attachments.build

    new!
  end

  def create
    @debit_invoice = DebitInvoice.new(params[:debit_invoice])
    @debit_invoice.build_booking if @debit_invoice.valid?

    create!
  end
end
