class BalanceController < ApplicationController

  def index
    redirect_to :action => 'show'
  end

  def show
    @company = current_tenant.company
    
    # use current date if not specified otherwise
    if params[:by_value_period]
      @date = Date.parse(params[:by_value_period][:to])
    else
      @date = Date.today
    end
  end
end
