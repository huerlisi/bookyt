class EmployeesController < InheritedResources::Base
  # Responders
  respond_to :html, :js

  protected
    def collection
      @employees ||= end_of_association_chain.paginate(:page => params[:page])
    end
end
