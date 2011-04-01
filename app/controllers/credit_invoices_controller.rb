class CreditInvoicesController < AuthorizedController
  # Actions
  def index
    @credit_invoices = CreditInvoice.with_balance.paginate(:page => params[:page])
  end
  
  def new
    # Allow pre-seeding some parameters
    invoice_params = {
      :customer_id => current_tenant.company.id,
      :state       => 'booked',
      :value_date  => Date.today,
      :due_date    => Date.today.in(30.days)
    }

    # Set default parameters
    invoice_params.merge!(params[:invoice]) if params[:invoice]

    @credit_invoice = CreditInvoice.new(invoice_params)
    
    new!
  end

  def create
    @credit_invoice = CreditInvoice.new(params[:credit_invoice])
    @credit_invoice.build_booking
    
    create!
  end
end
