class DirectBookingsController < InheritedResources::Base
  def new
    # Lookup and instantiate template
    booking_template = BookingTemplate.find(params[:direct_booking][:booking_template_id])
    @direct_booking = booking_template.build_booking(params[:direct_booking])
    @direct_booking.value_date ||= Date.today
  end

  def create
    @direct_booking = Booking.new(params[:direct_booking])
    
    create! {
      render 'list' and return
    }
  end
end
