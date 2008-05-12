class ProfitController < ApplicationController

  def index
    redirect_to :action => 'show'
  end

  def show
    # Client
    unless @client = Client.find(:first)
      redirect_to :controller => 'clients', :action => 'new'
      return
    end
    
    @start_date = params[:balance][:start_date] unless params[:balance].nil?
    @end_date = params[:balance][:end_date] unless params[:balance].nil?
    # use current date if not specified otherwise
    @end_date ||= Date.today
    @start_date ||= Date.today - 365
    Booking.send(:with_scope, :find => {:conditions => ['value_date BETWEEN ? AND ?', @start_date, @end_date]}) do
      render :action => :show
    end
  end
end
