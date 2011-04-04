module InvoiceHelper
  def states_as_collection
    states = Invoice::STATES
    states.inject({}) do |result, state|
      result[t(state, :scope => 'invoice.state')] = state
      result
    end
  end
end
