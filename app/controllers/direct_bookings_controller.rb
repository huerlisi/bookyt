class DirectBookingsController < InheritedResources::Base
  def new
    @direct_booking = Booking.new(params[:direct_booking])
  end

  def create
    @direct_booking = Booking.new(params[:direct_booking])
    
    create! {
      render 'list' and return
    }
  end
end
