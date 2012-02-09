module InvoiceHelper
  def invoice_states_as_collection
    states = Invoice::STATES
    states.inject({}) do |result, state|
      result[t(state, :scope => 'invoice.state')] = state
      result
    end
  end

  def invoice_label(invoice)
    type = case invoice.state
    when 'canceled', 'reactivated'
      nil
    when 'paid'
      'success'
    when 'reminded', '2xreminded', '3xreminded', 'encashment'
      'important'
    when 'booked', 'writte_off'
      'notice'
    end

    boot_label(t(invoice.state, :scope => 'invoice.state'), type)
  end
end
