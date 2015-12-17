class DebitInvoicesController < InvoicesController
  defaults :resource_class => DebitInvoice

  def letter
    pdf = DebitInvoicePDF.new(@debit_invoice, current_tenant)
    filename = pdf.filename
    data = pdf.call
    type = :pdf
    send_data data, filename: filename, type: type
  end

  # Actions
  def new
    # Allow pre-seeding some parameters
    text = t('letters.debit_invoice.closing')
    text += "\n\n" + t('letters.debit_invoice.greetings')
    text += "\n" + current_user.person.vcard.full_name
    text += "\n" + contact.to_s(:label) if contact = current_user.person.vcard.contacts.first
    text += "\n"*3

    # TODO: If current_tenant has no assigned company this won't fail, but the
    # input field is not show either.
    invoice_params = {
      :company_id => current_tenant.company.try(:id),
      :state      => 'booked',
      :value_date => Date.today,
      :due_date   => Date.today.in(current_tenant.payment_period.days).to_date,
      :title      => "Rechnung Nr.",
      :text       => text
    }

    # Set default parameters
    invoice_params.merge!(params[:invoice]) if params[:invoice]

    @debit_invoice = DebitInvoice.new(invoice_params)

    @debit_invoice.line_items.build(
      :times          => 1,
      :quantity       => 'x',
      :include_in_saldo_list  => ['vat:full'],
      :debit_account  => resource_class.balance_account,
      :credit_account => resource_class.profit_account
    )

    # Add vat line item at second last position
    if current_tenant.vat_obligation?
      @debit_invoice.line_items.build(
        :title          => 'MWSt.',
        :times          => 8,
        :quantity       => '%',
        :reference_code => 'vat:full',
        :debit_account  => resource_class.balance_account,
        :credit_account => Account.tagged_with('vat:credit').first
      )
    end

    new!
  end
end
