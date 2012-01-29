class DebitInvoicesController < InvoicesController
  defaults :resource_class => DebitInvoice

  # Actions
  def new
    # Allow pre-seeding some parameters
    month_name = t('date.month_names')[Date.today.month]
    invoice_params = {
      :company_id => current_tenant.company.id,
      :value_date => Date.today,
      :due_date   => Date.today.in(30.days).to_date,
      :title      => "Rechnung " + month_name
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

    # Add vat line item at very last position
    # TODO: debit account should not be hard coded
    if current_tenant.vat_number.present?
      @debit_invoice.line_items.build(
        :title          => 'MWSt.',
        :times          => 8,
        :quantity       => '%',
        :reference_code => 'vat:full',
        :position       => 100000,
        :credit_account => DebitInvoice.default_credit_account,
        :debit_account  => Account.find_by_code('2206')
      )
    end

    new!
  end

  def create
    invoice_params = {
      :state      => 'booked'
    }

    invoice_params.merge!(params[:debit_invoice]) if params[:debit_invoice]

    @debit_invoice = DebitInvoice.new(invoice_params)

    create!
    @debit_invoice.update_bookings
  end

  def update
    @debit_invoice = DebitInvoice.find(params[:id])

    update!
    @debit_invoice.update_bookings
  end
end
