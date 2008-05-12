class BalanceController < ApplicationController

  def index
    redirect_to :action => 'show'
  end

  def show
    # Client
    unless @client = Client.find(:first)
      redirect_to :controller => 'clients', :action => 'new'
      return
    end
    
    @date = params[:balance][:date] unless params[:balance].nil?
    # use current date if not specified otherwise
    @date ||= Date.today
    Booking.send(:with_scope, :find => {:conditions => ['value_date <= ?', @date]}) do
      render :action => :show
    end
  end
end
