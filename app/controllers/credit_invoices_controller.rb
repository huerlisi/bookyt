class CreditInvoicesController < AuthorizedController
  # Actions
  def new
    # Allow pre-seeding some parameters
    invoice_params = params[:invoice] || {}

    # Set default parameters
    invoice_params.merge!(:customer_id => current_tenant.company.id, :state => 'booked')

    @credit_invoice = CreditInvoice.new(invoice_params)
    
    new!
  end

  def create
    @credit_invoice = CreditInvoice.new(params[:credit_invoice])
    @credit_invoice.build_booking
    
    create!
  end
end
