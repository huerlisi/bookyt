class CreditInvoicesController < AuthorizedController
  public
  # Actions
  def new
    invoice_params = params[:invoice] || {}
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
