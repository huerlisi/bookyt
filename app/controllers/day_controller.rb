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
      redirect_to :action => 'cash_up'
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
    bills = params[:cash_register].select { |a| a[0].to_f > 5 }
    mint = params[:cash_register].select { |a| a[0].to_f <= 5 }
    
    cash = bills.map { |a| a[0].to_f * a[1].to_f }.sum
    cash += mint.map { |a| a[1].to_f }.sum
    
    render :inline => "<td style='font-weight: bolder'>#{cash}</td>"
  end
end
