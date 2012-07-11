class CreditInvoicesController < InvoicesController
  defaults :resource_class => CreditInvoice

  # Actions
  def new
    # Allow pre-seeding some parameters
    invoice_params = {
      :customer_id => current_tenant.company.id,
      :state       => 'booked',
      :value_date  => Date.today,
      :due_date    => Date.today.in(Settings.payment_period).to_date
    }

    # Set default parameters
    invoice_params.merge!(params[:invoice]) if params[:invoice]

    @credit_invoice = CreditInvoice.new(invoice_params)

    @credit_invoice.line_items.build(
      :times          => 1,
      :quantity       => 'x',
      :include_in_saldo_list => ['vat:full'],
      :credit_account => CreditInvoice.default_credit_account,
      :debit_account  => CreditInvoice.default_debit_account
    )

    new!
  end

  def create
    @credit_invoice = CreditInvoice.new(params[:credit_invoice])

    create!
  end
end
