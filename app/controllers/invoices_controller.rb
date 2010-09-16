class InvoicesController < InheritedResources::Base
  # Responders
  respond_to :html, :js

  protected
    def collection
      @invoices ||= end_of_association_chain.paginate(:page => params[:page])
    end
end
