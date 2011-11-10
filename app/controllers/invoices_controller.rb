class InvoicesController < AuthorizedController
  # States
  has_scope :by_state, :default => 'booked', :only => :index
  has_scope :by_text
  has_scope :overdue, :type => :boolean

  respond_to :html, :pdf

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

  # has_many :line_items
  def new_line_item
    if invoice_id = params[:id]
      @invoice = Invoice.find(invoice_id)
    else
      @invoice = resource_class.new
    end

    @line_item = @invoice.line_items.build(
      :times         => 1,
      :quantity      => 'x',
      :vat_rate_code => 'vat:full'
    )

    respond_with @line_item
  end
end
