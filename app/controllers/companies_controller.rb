class CompaniesController < PeopleController
  defaults :resource_class => Company

  def show
    @employments = resource.employments.paginate(:page => params[:page])
    super
  end
end
