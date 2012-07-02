module InvoiceHelper
  def invoice_states_as_collection
    states = Invoice::STATES
    states.inject({}) do |result, state|
      result[t(state, :scope => 'invoice.state')] = state
      result
    end
  end

  def suggested_invoices_for_booking(booking)
    invoices = Invoice.where(:amount => booking.amount)
    invoices.collect{|invoice| [invoice.to_s(:long), invoice.id]}
  end

  def invoice_label(invoice)
    invoice_state_label(invoice.state)
  end

  def t_invoice_filter(state)
    t(state, :scope => 'invoice.state')
  end

  def invoice_state_label(state, active = true)
    type = case state.to_s
    when 'canceled', 'reactivated'
      nil
    when 'paid'
      'success'
    when 'reminded', '2xreminded', '3xreminded', 'encashment'
      'important'
    when 'booked', 'written_off'
      'info'
    end

    type = 'disabled' unless active

    boot_label(t(state, :scope => 'invoice.state'), type)
  end
end
