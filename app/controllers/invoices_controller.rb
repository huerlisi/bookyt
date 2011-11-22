class InvoicesController < AuthorizedController
  # States
  has_scope :by_state, :default => proc {|controller| 'booked' if controller.params[:by_text].nil?}, :only => :index
  has_scope :overdue, :type => :boolean

  respond_to :html, :pdf

  def index
    set_collection_ivar resource_class.search(
      params[:by_text],
      :star => true,
      :page => params[:page],
      :conditions => current_scopes
    )
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

  # has_many :line_items
  def new_line_item
    if invoice_id = params[:id]
      @invoice = Invoice.find(invoice_id)
    else
      @invoice = resource_class.new
    end

    @line_item = @invoice.line_items.build(
      :times          => 1,
      :quantity       => 'x',
      :vat_rate_code  => 'vat:full',
      :contra_account => resource_class.default_contra_account
    )

    respond_with @line_item
  end

  def copy
    # Duplicate original invoice
    original_invoice = Invoice.find(params[:id])
    @invoice = original_invoice.dup

    # Override some fields
    @invoice.attributes = {
      :state         => 'booked',
      :value_date    => Date.today,
      :due_date      => Date.today.in(30.days).to_date,
      :duration_from => nil,
      :duration_to   => nil
    }

    # Rebuild positions
    @invoice.line_items = original_invoice.line_items.map{|line_item| line_item.dup}

    render 'edit'
  end
end
