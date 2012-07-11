class DebitInvoicesController < InvoicesController
  defaults :resource_class => DebitInvoice

  # Actions
  def new
    # Allow pre-seeding some parameters
    invoice_params = {
      :company_id => current_tenant.company.id,
      :state      => 'booked',
      :value_date => Date.today,
      :due_date   => Date.today.in(Settings.payment_period).to_date,
      :title      => "Rechnung Nr."
    }

    # Set default parameters
    invoice_params.merge!(params[:invoice]) if params[:invoice]

    @debit_invoice = DebitInvoice.new(invoice_params)

    @debit_invoice.line_items.build(
      :times          => 1,
      :quantity       => 'x',
      :include_in_saldo_list  => ['vat:full'],
      :credit_account => DebitInvoice.default_credit_account,
      :debit_account  => DebitInvoice.default_debit_account
    )

    # Add vat line item at second last position
    # TODO: debit account should not be hard coded
    if current_tenant.vat_obligation?
      @debit_invoice.line_items.build(
        :title          => 'MWSt.',
        :times          => 8,
        :quantity       => '%',
        :reference_code => 'vat:full',
        :credit_account => DebitInvoice.default_credit_account,
        :debit_account  => Account.find_by_code('2200')
      )
    end

    new!
  end

  def create
    invoice_params = {}

    invoice_params.merge!(params[:debit_invoice]) if params[:debit_invoice]

    @debit_invoice = DebitInvoice.new(invoice_params)

    create!
  end

  def update
    @debit_invoice = DebitInvoice.find(params[:id])

    update!
  end
end
