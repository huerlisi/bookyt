class DebitInvoicesController < AuthorizedController
  # Actions
  def new
    # Allow pre-seeding some parameters
    invoice_params = {:company_id => current_tenant.company.id, :state => 'booked'}

    # Set default parameters
    invoice_params.merge!(params[:invoice]) if params[:invoice]

    @debit_invoice = DebitInvoice.new(invoice_params)
    
    new!
  end

  def create
    @debit_invoice = DebitInvoice.new(params[:debit_invoice])
    @debit_invoice.build_booking
    
    create!
  end
end
