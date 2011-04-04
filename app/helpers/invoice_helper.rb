module InvoiceHelper
  def states_as_collection
    states = ['booked', 'canceled', 'paid']
    states.inject({}) do |result, state|
      result[t(state, :scope => 'invoice.state')] = state
      result
    end
  end
end
