class ProfitController < ApplicationController

  def index
    redirect_to :action => 'show'
  end

  def show
    @client = Client.find(:first)
  end
end
