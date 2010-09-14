class EmployersController < InheritedResources::Base
  # Responders
  respond_to :html, :js

  protected
    def collection
      @employers ||= end_of_association_chain.paginate(:page => params[:page])
    end
end
