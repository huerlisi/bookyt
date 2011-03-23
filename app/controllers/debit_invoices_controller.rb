class DebitInvoicesController < AuthorizedController
  # Actions
  def new
    invoice_params = params[:invoice] || {}
    invoice_params.merge!(:company_id => current_tenant.company.id, :state => 'booked')
    @debit_invoice = DebitInvoice.new(invoice_params)
    
    new!
  end

  def create
    @debit_invoice = DebitInvoice.new(params[:debit_invoice])
    @debit_invoice.build_booking
    
    create!
  end
end
