class DebitInvoicesController < AuthorizedController
  # States
  has_scope :by_state
  has_scope :by_text

  # Actions
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
    
    # Prebuild an empty attachment instance
    @debit_invoice.attachments.build
    
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
