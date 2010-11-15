class InvoicesController < AuthorizedController
  public
  # Actions
  def new
    invoice_params = params[:invoice] || {}
    invoice_params.merge!(:company_id => current_tenant.company.id)
    @invoice = Invoice.new(invoice_params)
    
    new!
  end
end
