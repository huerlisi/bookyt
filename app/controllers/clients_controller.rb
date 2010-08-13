class ClientsController < InheritedResources::Base
  protected
    def collection
      @clients ||= end_of_association_chain.paginate(:page => params[:page])
    end
end
