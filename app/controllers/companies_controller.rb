class CompaniesController < InheritedResources::Base
  # Responders
  respond_to :html, :js

  protected
    def collection
      @companies ||= end_of_association_chain.paginate(:page => params[:page])
    end
end
