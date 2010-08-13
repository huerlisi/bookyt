class AccountTypesController < InheritedResources::Base
  protected
    def collection
      @account_types ||= end_of_association_chain.paginate(:page => params[:page])
    end
end
