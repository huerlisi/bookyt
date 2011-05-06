class InvoicesController < AuthorizedController
  # States
  has_scope :by_state, :default => 'booked', :only => :index
  has_scope :by_text
  
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
