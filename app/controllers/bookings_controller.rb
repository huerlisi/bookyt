class BookingsController < InheritedResources::Base
  # Responders
  respond_to :html, :js
 
  def new
    @booking = Booking.new(:value_date => Date.today)
    new!
  end
  
  def select_booking
    @booking = Booking.find(params[:id]).clone
    @booking.value_date = params[:booking][:value_date]
    render :action => 'edit'
  end
  
  def select_booking_template
    @booking_template = BookingTemplate.find(params[:id]).clone
    @booking_params = @booking_template.attributes.reject{|key, value| ["updated_at", "created_at", "id"].include?(key)}

    @booking = Booking.new(@booking_params)
    @booking.value_date = params[:booking][:value_date]
    render :action => 'edit'
  end
  
  def select
    @booking = Booking.new(params[:booking])
    @booking_templates = BookingTemplate.all.paginate(:page => params[:page])
    @bookings = Booking.where("title LIKE ?", '%' + @booking.title + '%').order('value_date DESC').paginate(:page => params[:page])
  end
  
  def create
    @booking = Booking.new(params[:booking])

    create! do |success, failure|
      success.html {redirect_to new_booking_path(:notice => render_to_string(:partial => 'layouts/flash_new', :locals => {:object => @booking}))}
      failure.html {render 'edit'}
    end
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
