module InvoiceHelper
  def invoice_states_as_collection
    states = Invoice::STATES
    states.inject({}) do |result, state|
      result[t(state, :scope => 'invoice.state')] = state
      result
    end
  end

  def vat_rates_as_collection
    vats = VatRate.latest

    vats.inject({}) do |result, item|
      result[item.title] = item.code
      result
    end
  end
end
