class InvoicesController < AuthorizedController
  # States
  has_scope :by_state, :default => proc {|controller| 'booked' if controller.params[:by_text].nil?}, :only => :index
  has_scope :overdue, :type => :boolean

  respond_to :html, :pdf

  def index
    conditions = current_scopes
    conditions.delete(:by_state) if conditions[:by_state] == 'all'

    set_collection_ivar resource_class.search(
      params[:by_text],
      :star => true,
      :order => :due_date,
      :sort_mode => :desc,
      :page => params[:page],
      :conditions => conditions
    )

    index!
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

    case params[:klass]
    when 'SaldoLineItem'
      klass = SaldoLineItem
    else
      klass = LineItem
    end

    @line_item = klass.new(
      :times          => 1,
      :quantity       => 'x',
      :include_in_saldo_list => ['vat:full'],
      :credit_account => resource_class.default_credit_account,
      :debit_account  => resource_class.default_debit_account
    )
    @invoice.line_items << @line_item

    respond_with @line_item
  end

  def copy
    # Duplicate original invoice
    original_invoice = Invoice.find(params[:id])
    invoice = original_invoice.copy

    # Override some fields
    invoice.attributes = {
      :state         => 'booked',
      :value_date    => Date.today,
      :due_date      => Date.today.in(30.days).to_date,
      :duration_from => nil,
      :duration_to   => nil
    }

    # Rebuild positions
    invoice.line_items = original_invoice.line_items.map{|line_item| line_item.copy}
    set_resource_ivar invoice

    render 'edit'
  end
end
