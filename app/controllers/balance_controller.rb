class BalanceController < ApplicationController

  def index
    show
    render :action => 'show'
  end

  def show
    client_id = params[:id] || session[:client_id]
    @client = Client.find(client_id)
  end
end
