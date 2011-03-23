class DirectBookingsController < InheritedResources::Base
  def new
    @direct_booking = Booking.new(params[:direct_booking])
    @direct_booking.value_date ||= Date.today
  end

  def create
    @direct_booking = Booking.new(params[:direct_booking])
    
    create! {
      render 'list' and return
    }
  end
end
