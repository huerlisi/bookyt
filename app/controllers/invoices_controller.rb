class InvoicesController < AuthorizedController
  def index
    @invoices = Invoice.with_balance.paginate(:page => params[:page])
  end
  
  # Actions
  def new
    invoice_params = params[:invoice] || {}
    invoice_params.merge!(:company_id => current_tenant.company.id)
    @invoice = Invoice.new(invoice_params)
    
    new!
  end

  def letter
    show!
  end
end
