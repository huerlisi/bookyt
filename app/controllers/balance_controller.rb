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

    # use current date if not specified otherwise
    params[:balance] ||= {}
    params[:balance][:date] ||= Date.today.to_s

    @date = Date.parse(params[:balance][:date])
  end
end
