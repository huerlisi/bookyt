class DaysController < AuthorizedController
  def create
    create! {days_path}
  end

  # AJAX methods
  def calculate_cash
    bills = params[:cash_register].select { |a| a[0].to_f > 5 }
    mint = params[:cash_register].select { |a| a[0].to_f <= 5 }

    @cash = bills.map { |a| a[0].to_f * a[1].to_f }.sum
    @cash += mint.map { |a| a[1].to_f }.sum
  end
end
