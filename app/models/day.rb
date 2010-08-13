class Day < ActiveRecord::Base
  after_update :create_bookings
  
  private
  def create_bookings
    BookingTemplate.where(:title => "Bareinnahmen").first.build_booking(:amount => cash, :value_date => date).save
    BookingTemplate.where(:title => "Kreditkarten Einnahmen").first.build_booking(:amount => card_turnover, :value_date => date).save
  end
end
