class PeopleController < AuthorizedController
  def show
    @credit_invoices = resource.credit_invoices
    @debit_invoices = resource.debit_invoices

    # Invoice scoping by state
    by_state = params[:by_state] || 'booked'
    @credit_invoices = @credit_invoices.by_state(by_state)
    @debit_invoices = @debit_invoices.by_state(by_state)

    show!
  end
end
