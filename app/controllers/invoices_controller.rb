class InvoicesController < AuthorizedController
  # States
  has_scope :invoice_state, :default => proc {|controller| 'booked' if controller.params[:by_text].nil?}, :only => :index
  has_scope :by_text
  has_scope :overdue, :type => :boolean

  respond_to :html, :pdf

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
      @line_item = SaldoLineItem.new
    else
      @line_item = LineItem.new(
        :times          => 1,
        :quantity       => 'x',
        :include_in_saldo_list => ['vat:full'],
        :credit_account => resource_class.credit_account,
        :debit_account  => resource_class.debit_account
      )
    end

    @invoice.line_items << @line_item

    respond_with @line_item
  end

  def copy
    # Duplicate original invoice
    original_invoice = Invoice.find(params[:id])
    invoice = original_invoice.copy(current_tenant.payment_period.days)

    set_resource_ivar invoice

    render 'edit'
  end
end
