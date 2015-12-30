class TenantsController < AuthorizedController
  # Actions
  def profit_sheet
    prepare_sheet
  end

  def balance_sheet
    prepare_sheet
  end

  def vat_report
    @accounts = Account.tagged_with('vat')
    if from = params.fetch(:by_date, {}).fetch(:from, nil)
      @year = Date.parse(from).year
    else
      @year = Date.today.year
    end
    @quarters = [
      Date.new(@year, 1)..Date.new(@year, 3, -1),
      Date.new(@year, 4)..Date.new(@year, 6, -1),
      Date.new(@year, 7)..Date.new(@year, 9, -1),
      Date.new(@year, 10)..Date.new(@year, 12, -1)
    ]
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
