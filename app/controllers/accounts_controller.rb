class AccountsController < AuthorizedController
  # Scopes
  has_scope :by_value_period, :using => [:from, :to], :default => proc { |c| c.session[:has_scope] }
  has_scope :by_text

  def index
    @accounts = apply_scopes(Account).includes(:account_type).includes(:credit_bookings, :credit_bookings)
  end

  def show
    @account = Account.find(params[:id])
    @bookings = apply_scopes(Booking).includes(:debit_account => :account_type, :credit_account => :account_type).by_account(@account)

    if params[:only_credit_bookings]
      @bookings = @bookings.where(:credit_account_id => @account.id)
    end
    if params[:only_debit_bookings]
      @bookings = @bookings.where(:debit_account_id => @account.id)
    end
    @bookings = @bookings.paginate(:page => params['page'], :per_page => params['per_page'], :order => 'value_date, id')
    @carry_booking = @bookings.all.first

    show!
  end

  def csv_bookings
    @account = Account.find(params[:id])
    @bookings = apply_scopes(Booking).by_account(@account)
    send_csv @bookings, :only => [:value_date, :title, :comments, :amount, 'credit_account.code', 'debit_account.code'], :filename => "%s-%s.csv" % [@account.code, @account.title]
  end

  def edit_bookings
    @account = Account.find(params[:id])
    @bookings = apply_scopes(Booking).by_account(@account)
  end

  def update_bookings
    bookings = params[:bookings]

    bookings.each do |id, attributes|
      attributes.merge!({:credit_account_id => Account.find_by_code(attributes[:credit_account_code]).id})
      attributes.merge!({:debit_account_id => Account.find_by_code(attributes[:debit_account_code]).id})
      Booking.find(id).update_attributes(attributes)
    end

    account = Account.find(params[:id])
    redirect_to account
  end
end
