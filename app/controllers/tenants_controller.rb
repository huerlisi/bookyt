class TenantsController < AuthorizedController
  # Actions
  def profit_sheet
    prepare_sheet
  end

  def balance_sheet
    prepare_sheet
  end

  private
  def prepare_sheet
    # use current date if not specified otherwise
    if params[:by_date]
      # TODO: check on :to and :from to not be nil
      @end_date = Date.parse(params[:by_date][:to])
      @start_date = Date.parse(params[:by_date][:from])
      @dates = [@start_date..@end_date]
    elsif params[:years]
      @dates = params[:years].map{|year| current_tenant.fiscal_period(year.to_i)[:from]..current_tenant.fiscal_period(year.to_i)[:to]}
    else
      @end_date = Date.today
      @start_date = @end_date.to_time.advance(:years => -1, :days => 1).to_date
      @dates = [@start_date..@end_date]
    end
  end
end
