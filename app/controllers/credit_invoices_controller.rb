class CreditInvoicesController < AuthorizedController
  public
  # Actions
  def new
    invoice_params = params[:invoice] || {}
    invoice_params.merge!(:customer_id => current_tenant.company.id, :state => 'booked')
    @invoice = Invoice.new(invoice_params)
    
    new!
  end
end
