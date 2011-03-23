class Invoice < ActiveRecord::Base
  # Aspects
  include ApplicationHelper
  
  # Associations
  belongs_to :customer, :class_name => 'Person'
  belongs_to :company, :class_name => 'Person'
  
  # Validations
  validates_date :due_date, :value_date
  validates_presence_of :customer, :company, :title, :amount, :state
  
  # Bookings
  has_many :bookings, :as => :reference

  def build_booking
    booking = bookings.build(:amount => amount, :value_date => value_date)
    booking.booking_template_id = BookingTemplate.find_by_code('credit_invoice:invoice').id
    
    booking
  end

  # Helpers
  def to_s
    return "" if amount.nil?

    "%s für %s à %s"  % [title, customer, currency_fmt(amount)]
  end
end
