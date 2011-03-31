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
    self.class.direct_account
  end
  
  has_many :bookings, :as => :reference, :dependent => :destroy do
    # TODO: duplicated in Booking (without parameter)
    def direct_balance(value_date = nil, direct_account = nil)
      # Guard
      return 0.0 unless proxy_owner.direct_account
      
      direct_account ||= proxy_owner.direct_account

      direct_bookings = scoped
      direct_bookings = direct_bookings.where("value_date <= ?", value_date) if value_date

      direct_bookings.with_direct_amount(direct_account).first.direct_amount
    end
  end

  def build_booking
    booking = bookings.build(:amount => amount, :value_date => value_date)
    booking.booking_template_id = BookingTemplate.find_by_code('credit_invoice:invoice').id
    
    booking
  end

  scope :with_balance, Proc.new {
    direct_account_id = self.direct_account.id
    
    joins(:bookings).group('invoices.id').select("sum(CASE WHEN bookings.debit_account_id = #{direct_account_id} THEN bookings.amount WHEN bookings.credit_account_id = #{direct_account_id} THEN -bookings.amount ELSE 0.0 END) AS balance, *")
  }
  
  # Helpers
  def to_s
    return "" if amount.nil?

    "%s für %s à %s"  % [title, customer, currency_fmt(amount)]
  end
end
