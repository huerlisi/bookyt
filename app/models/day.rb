class Day < ActiveRecord::Base
  # Associations
  validates_date :date

  # Scopes
  default_scope :order => 'date DESC'

  # Helpers
  def to_s
    "%s: brutto %0.2f, netto %0.2f" % [date, gross_turnover, net_turnover]
  end

  # Callbacks
  after_create :create_bookings

  private
  def create_bookings
    BookingTemplate.create_booking('day:cash', :amount => cash, :value_date => date)
    BookingTemplate.create_booking('day:card turnover', :amount => card_turnover, :value_date => date)
    BookingTemplate.create_booking('day:expenses', :amount => expenses, :value_date => date)
    BookingTemplate.create_booking('day:credit_turnover', :amount => credit_turnover, :value_date => date)
  end
end
