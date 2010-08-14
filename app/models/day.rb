class Day < ActiveRecord::Base
  after_update :create_bookings
  
  private
  def create_bookings
    BookingTemplate.where(:title => "Bareinnahmen").first.create_booking(:amount => cash, :value_date => date)
    BookingTemplate.where(:title => "Kreditkarten Einnahmen").first.create_booking(:amount => card_turnover, :value_date => date)
  end
end
