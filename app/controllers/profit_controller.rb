class ProfitController < ApplicationController

  def index
    redirect_to :action => 'show'
  end

  def show
    # Client
    unless @client = Client.find(:first)
      redirect_to :controller => 'clients', :action => 'new'
      return
    end
    
    # use current date if not specified otherwise
    params[:profit] ||= {}
    
    # use current date if not specified otherwise
    params[:profit][:end_date] ||= Date.today.to_s
    @end_date = Date.parse(params[:profit][:end_date])
    
    @start_date = @end_date.to_time.advance(:years => -1, :days => 1).to_date

    @date = @start_date..@end_date
    render :action => :show
  end
end
