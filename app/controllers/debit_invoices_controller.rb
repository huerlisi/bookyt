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
      :quantity      => 1,
      :price         => @debit_invoice.amount,
      :vat_rate_code => 'vat:full'
    )

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
    if @debit_invoice.save
      @debit_invoice.build_booking.save
    end

    create!
  end

  # has_many :line_items
  def new_line_item
    if invoice_id = params[:id]
      @invoice = Invoice.find(invoice_id)
    else
      @invoice = DebitInvoice.new
    end

    @line_item = @invoice.line_items.build

    respond_with @line_item
  end
end
