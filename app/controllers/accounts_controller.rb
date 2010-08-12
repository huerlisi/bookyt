class AccountsController < InheritedResources::Base
  def index
    @accounts = Account.paginate :page => params[:page], :per_page => 50, :order => 'number'
    
    index!
  end
  
  def show
    @account = Account.find(params[:id])
    @bookings = Booking.by_account(@account)
    if params[:only_credit_bookings]
      @bookings = @bookings.where(:credit_account_id => @account.id)
    end
    if params[:only_debit_bookings]
      @bookings = @bookings.where(:debit_account_id => @account.id)
    end
    @bookings = @bookings.paginate(:page => params['page'], :per_page => 20, :order => 'value_date, id')
        
    show!
  end
end
