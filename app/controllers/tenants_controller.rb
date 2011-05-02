class TenantsController < AuthorizedController
  # Actions
  def current
    redirect_to current_user.tenant
  end

  def profit_sheet
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
  end

  def balance_sheet
    @company = current_tenant.company
    
    # use current date if not specified otherwise
    if params[:by_value_period]
      @date = Date.parse(params[:by_value_period][:to])
    else
      @date = Date.today
    end
  end
end
