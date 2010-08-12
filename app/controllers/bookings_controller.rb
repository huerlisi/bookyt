class BookingsController < InheritedResources::Base
  # Responders
  respond_to :html, :js
 
  # Inplace Editing
  in_place_edit_for :booking, :title
  in_place_edit_for :booking, :comments
  in_place_edit_for :booking, :in_place_amount
  in_place_edit_for :booking, :value_date

  def new
    @booking = Booking.new(:value_date => Date.today)
    new!
  end
  
  def select
    @booking = Booking.new(params[:booking])
    @booking_templates = BookingTemplate.all.paginate(:page => params[:page])
  end
  
  def create
    @booking = Booking.new(params[:booking])

    @booking.save
    create!(:notice => render_to_string(:partial => 'layouts/flash_new', :locals => {:object => @booking})) { new_booking_path }
  end
  
  def index
    order_by = params[:order] || 'value_date'
    @bookings = Booking.paginate :page => params[:page], :per_page => 100, :order => order_by
    index!
  end

  def copy
    @booking = Booking.find(params[:id])
    new_booking = @booking.clone
    new_booking.save
    render :partial => 'booking', :object => new_booking
  end
end
