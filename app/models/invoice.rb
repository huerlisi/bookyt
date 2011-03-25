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
  def direct_account
    nil
  end
  
  has_many :bookings, :as => :reference, :dependent => :destroy do
    # TODO: duplicated in Booking (without parameter)
    def direct_balance(value_date = nil, direct_account = nil)
      return 0.0 unless proxy_owner.direct_account
      
      direct_account ||= proxy_owner.direct_account
      balance = 0.0

      direct_bookings = scoped
      direct_bookings = direct_bookings.where("value_date <= ?", value_date) if value_date

      for booking in direct_bookings.all
        balance += booking.accounted_amount(direct_account)
      end

      balance
    end
  end

  def build_booking
    booking = bookings.build(:amount => amount, :value_date => value_date)
    booking.booking_template_id = BookingTemplate.find_by_code('credit_invoice:invoice').id
    
    booking
  end

  # TODO: called due_amount in CyDoc
  def balance(value_date = nil)
    bookings.direct_balance(value_date)
  end
  
  # Helpers
  def to_s
    return "" if amount.nil?

    "%s für %s à %s"  % [title, customer, currency_fmt(amount)]
  end
end
