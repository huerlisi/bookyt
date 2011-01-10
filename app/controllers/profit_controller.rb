class ProfitController < ApplicationController
  has_scope 
  def index
    redirect_to :action => 'show'
  end

  def show
    @company = current_tenant.company
    
    # use current date if not specified otherwise
    params[:profit] ||= {}
    
    # use current date if not specified otherwise
    if params[:by_value_period]
      @end_date = Date.parse(params[:by_value_period][:to])
      @start_date = Date.parse(params[:by_value_period][:from])
    else
      @end_date = Date.today
      @start_date = @end_date.to_time.advance(:years => -1, :days => 1).to_date
    end

    @date = @start_date..@end_date
    render :action => :show
  end
end
