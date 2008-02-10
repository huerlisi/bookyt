class BalanceController < ApplicationController

  def index
    show
    render :action => 'show'
  end

  def show
    @date = params[:balance][:date] unless params[:balance].nil?
    # use current date if not specified otherwise
    @date ||= Date.today
    @client = Client.find(:first)
    Booking.with_scope(:find => {:conditions => ['value_date <= ?', @date]}) do
      render :action => :show
    end
  end
end
