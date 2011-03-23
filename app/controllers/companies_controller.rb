class CompaniesController < AuthorizedController
  def show
    @employments = resource.employments.paginate(:page => params[:page])
    
    show!
  end
end
