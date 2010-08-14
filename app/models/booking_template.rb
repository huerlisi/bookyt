class BookingTemplate < ActiveRecord::Base
  # Associations
  belongs_to :debit_account, :foreign_key => 'debit_account_id', :class_name => "Account"
  belongs_to :credit_account, :foreign_key => 'credit_account_id', :class_name => "Account"

  # Validations
  validates_date :value_date, :allow_nil => true

  # Standard methods
  def to_s(format = :default)
    case format
    when :short
      "%s: %s / %s CHF %s" % [
        value_date ? value_date : '?',
        credit_account ? credit_account.code : '?',
        debit_account ? debit_account.code : '?',
        amount ? "%0.2f" % amount : '?',
      ]
    else
      "%s: %s an %s CHF %s, %s (%s)" % [
        value_date ? value_date : '?',
        credit_account ? "#{credit_account.title} (#{credit_account.code})" : '?',
        debit_account ? "#{debit_account.title} (#{debit_account.code})" : '?',
        amount ? "%0.2f" % amount : '?',
        title.present? ? title : '?',
        comments.present? ? comments : '?'
      ]
    end
  end

  def build_booking(params = {})
    booking_params = attributes.reject{|key, value| ["updated_at", "created_at", "id", "code"].include?(key)}
    booking_params.merge!(params)

    booking = Booking.new(booking_params)
    
    return booking
  end

  def create_booking(params = {})
    booking = build_booking(params)
    booking.save
    
    return booking
  end

  def self.create_booking(code, params = {})
    template = find_by_code(code)
    return if template.nil?
    
    template.create_booking(params)
  end
end
