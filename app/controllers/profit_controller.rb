class ProfitController < ApplicationController

  def index
    show
    render :action => 'show'
  end

  def show
    @client = Client.find(:first)
  end
end
