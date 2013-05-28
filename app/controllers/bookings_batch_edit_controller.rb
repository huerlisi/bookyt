class BookingsBatchEditController < ApplicationController
  def index
    @bookings = Booking.all
  end
end
