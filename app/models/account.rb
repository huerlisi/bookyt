class Account < ActiveRecord::Base
  belongs_to :client
  belongs_to :account_type
  
  has_many :credit_bookings, :class_name => "Booking", :foreign_key => "credit_account_id"
  has_many :debit_bookings, :class_name => "Booking", :foreign_key => "debit_account_id"

  has_many :bookings, :class_name => "Booking", :finder_sql => 'SELECT * FROM bookings WHERE credit_account_id = #{id} OR debit_account_id = #{id} ORDER BY value_date DESC'
  
  def saldo
    credit_amount = credit_bookings.sum(:amount)
    debit_amount = debit_bookings.sum(:amount)
    
    credit_amount ||= 0
    debit_amount ||= 0
    
    return credit_amount - debit_amount
  end

  def saldo=(value)
    booking = Booking.new
    amount = value.to_f
    if amount > 0
      booking.amount = amount
      booking.credit_account_id = self.id
    elsif amount < 0
      booking.amount = amount.abs
      booking.debit_account_id = self.id
    end
  end
end
