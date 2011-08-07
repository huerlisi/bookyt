class CustomersController < PeopleController
  def show
    # Invoice scoping by state
    by_state = params[:by_state] || 'all'
    @debit_invoices = resource.invoices.reorder('due_date DESC').by_state(by_state)

    show!
  end
end
