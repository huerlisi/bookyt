class BookingsController < InheritedResources::Base
  in_place_edit_for :booking, :title
  in_place_edit_for :booking, :comments
  in_place_edit_for :booking, :in_place_amount
  in_place_edit_for :booking, :in_place_value_date

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
