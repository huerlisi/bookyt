class ProfitController < ApplicationController

  def index
    redirect_to :action => 'show'
  end

  def show
    @start_date = params[:balance][:start_date] unless params[:balance].nil?
    @end_date = params[:balance][:end_date] unless params[:balance].nil?
    # use current date if not specified otherwise
    @end_date ||= Date.today
    @start_date ||= Date.today - 365
    @client = Client.find(:first)
    Booking.with_scope(:find => {:conditions => ['value_date BETWEEN ? AND ?', @start_date, @end_date]}) do
      render :action => :show
    end
  end
end
