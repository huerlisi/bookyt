class DebitInvoicesController < InvoicesController
  defaults :resource_class => DebitInvoice

  # Actions
  def new
    # Allow pre-seeding some parameters
    invoice_params = {
      :company_id => current_tenant.company.id,
      :state      => 'booked',
      :value_date => Date.today,
      :due_date   => Date.today.in(current_tenant.payment_period.days).to_date,
      :title      => "Rechnung Nr."
    }

    # Set default parameters
    invoice_params.merge!(params[:invoice]) if params[:invoice]

    @debit_invoice = DebitInvoice.new(invoice_params)

    @debit_invoice.line_items.build(
      :times          => 1,
      :quantity       => 'x',
      :include_in_saldo_list  => ['vat:full'],
      :credit_account => resource_class.balance_account,
      :debit_account  => resource_class.profit_account
    )

    # Add vat line item at second last position
    if current_tenant.vat_obligation?
      @debit_invoice.line_items.build(
        :title          => 'MWSt.',
        :times          => 8,
        :quantity       => '%',
        :reference_code => 'vat:full',
        :credit_account => resource_class.credit_account,
        :debit_account  => Account.tagged_with('vat:credit').first
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
end
