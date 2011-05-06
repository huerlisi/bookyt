class CreditInvoicesController < InvoicesController
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
    
    # Prebuild an empty attachment instance
    @credit_invoice.attachments.build
    
    new!
  end

  def create
    @credit_invoice = CreditInvoice.new(params[:credit_invoice])
    @credit_invoice.build_booking
    
    create!
  end
end
