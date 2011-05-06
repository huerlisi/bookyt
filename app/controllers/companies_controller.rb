class CompaniesController < PeopleController
  def show
    @employments = resource.employments.paginate(:page => params[:page])
    super
  end
end
