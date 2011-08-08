class CustomersController < PeopleController
  def show
    # Invoice scoping by state
    by_state = params[:by_state] || 'all'
    @open_debit_invoices = resource.invoices.reorder('due_date DESC').by_state('booked')
    @paid_debit_invoices = resource.invoices.reorder('due_date DESC').by_state(['canceled', 'paid'])

    show!
  end
end
