class DebitInvoicesController < AuthorizedController
  # Actions
  def index
    @debit_invoices = DebitInvoice.with_balance.paginate(:page => params[:page])
  end
  
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
    
    new!
  end

  def create
    @debit_invoice = DebitInvoice.new(params[:debit_invoice])
    @debit_invoice.build_booking
    
    create!
  end

  def letter
    show!
  end
end
