class Day < ActiveRecord::Base
  after_update :create_bookings
  
  private
  def create_bookings
    BookingTemplate.create_booking('day:cash', :amount => cash, :value_date => date)
    BookingTemplate.create_booking('day:card turnover', :amount => card_turnover, :value_date => date)
  end
end
