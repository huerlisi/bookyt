class BookingsController < ApplicationController
  in_place_edit_for :booking, :title
  in_place_edit_for :booking, :comments

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    order_by = params[:order] || 'value_date'
    @booking_pages, @bookings = paginate :bookings, :per_page => 100, :order => order_by
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(params[:booking])
    if @booking.save
      flash[:notice] = 'Booking was successfully created.'
      redirect_to :action => 'new'
    else
      render :action => 'new'
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def copy
    @booking = Booking.find(params[:id])
    new_booking = @booking.clone
    new_booking.save
    render :action => 'list'
  end
  
  def update
    @booking = Booking.find(params[:id])
    if @booking.update_attributes(params[:booking])
      flash[:notice] = 'Booking was successfully updated.'
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end

  def destroy
    Booking.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
