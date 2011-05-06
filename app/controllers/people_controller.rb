class PeopleController < AuthorizedController
  def show
    @credit_invoices = resource.credit_invoices
    @debit_invoices = resource.debit_invoices
    
    show!
  end
end
