class DayController < ApplicationController

  def new
    @day = Day.new
    @day.save
  end

  def cash_up
    # Create Day object for today unless called for specific day
    if params[:id]
      @day = Day.find(params[:id])
    else
      @day = Day.new(:date => Date.today)
      @day.save
    end
  end

  def update
    @day = Day.find(params[:id])
    if @day.update_attributes(params[:day])
      redirect_to :action => 'list'
    else
      render :action => 'cash_up'
    end
  end

  def list
    @days = Day.find :all
  end

  def index
    list
    render :action => 'list'
  end

  # AJAX methods
  def calculate_cash
    cash = params[:cash_register].values.map {|a| a.to_f }.sum
    render :text => "<td>#{cash}</td>"
  end
end
