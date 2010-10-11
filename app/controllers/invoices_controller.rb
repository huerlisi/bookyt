class InvoicesController < InheritedResources::Base
  # Responders
  respond_to :html, :js

  protected
    def collection
      @invoices ||= end_of_association_chain.paginate(:page => params[:page])
    end

  public
  def new
    invoice_params = params[:invoice] || {}
    invoice_params.merge!(:company_id => current_user.person.employers.first.id)
    @invoice = Invoice.new(invoice_params)
    
    new!
  end
end
