class CompaniesController < AuthorizedController
  def show
    @employments = resource.employments.paginate(:page => params[:page])
    @credit_invoices = resource.credit_invoices.paginate(:page => params[:page])
    @debit_invoices = resource.debit_invoices.paginate(:page => params[:page])
    
    show!
  end
end
