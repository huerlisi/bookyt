class AccountsController < AuthorizedController
  # Scopes
  has_scope :by_value_period, :using => [:from, :to], :default => proc { |c| c.session[:has_scope] }
  has_scope :by_text

  def show
    @account = Account.find(params[:id])
    @bookings = apply_scopes(Booking).by_account(@account)
    
    if params[:only_credit_bookings]
      @bookings = @bookings.where(:credit_account_id => @account.id)
    end
    if params[:only_debit_bookings]
      @bookings = @bookings.where(:debit_account_id => @account.id)
    end
    @bookings = @bookings.paginate(:page => params['page'], :per_page => params['per_page'], :order => 'value_date, id')
        
    show!
  end

  def csv_bookings
    @account = Account.find(params[:id])
    @bookings = apply_scopes(Booking).by_account(@account)
    send_csv @bookings, :only => [:value_date, :title, :comments, :amount, 'credit_account.code', 'debit_account.code'], :filename => "%s-%s.csv" % [@account.code, @account.title]
  end
end
