class CompaniesController < AuthorizedController
  def show
    @employments = resource.employments.paginate(:page => params[:page])

    @credit_invoices = resource.credit_invoices.paginate(:page => params[:page])
    @credit_invoices_amount = resource.credit_invoices.to_a.sum(&:amount)
    @credit_invoices_balance = resource.credit_invoices.to_a.sum(&:balance)

    @debit_invoices = resource.debit_invoices.paginate(:page => params[:page])
    @debit_invoices_amount = resource.debit_invoices.to_a.sum(&:amount)
    @debit_invoices_balance = resource.debit_invoices.to_a.sum(&:balance)
    
    show!
  end
end
