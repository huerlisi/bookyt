class BookingTemplate < ActiveRecord::Base
  # Associations
  belongs_to :debit_account, :foreign_key => 'debit_account_id', :class_name => "Account"
  belongs_to :credit_account, :foreign_key => 'credit_account_id', :class_name => "Account"

  # Scopes
  scope :by_type, lambda{|value| where("code LIKE ?", value + ':%')}
  
  # Standard methods
  def to_s(format = :default)
    case format
    when :short
      "%s / %s CHF %s" % [
        credit_account ? credit_account.to_s(:short) : '?',
        debit_account ? debit_account.to_s(:short) : '?',
        amount ? "%0.2f" % amount.to_f : '?',
      ]
    else
      "%s an %s CHF %s, %s (%s)" % [
        credit_account ? credit_account.to_s : '?',
        debit_account ? debit_account.to_s : '?',
        amount ? "%0.2f" % amount.to_f : '?',
        title.present? ? title : '?',
        comments.present? ? comments : '?'
      ]
    end
  end

  def booking_parameters(params = {})
    # Prepare parameters set by template
    booking_params = attributes.reject!{|key, value| !["title", "comments", "credit_account_id", "debit_account_id"].include?(key)}

    # Calculate amount
    booking_amount = BigDecimal.new(attributes['amount'] || '0')

    if ref_type = params['reference_type'] and ref_id = params['reference_id']
      reference = ref_type.constantize.find(ref_id)

      case self.amount_relates_to
        when 'reference_amount'
          booking_amount *= reference.amount
        when 'reference_balance'
          booking_amount *= reference.balance
        when 'reference_amount_minus_balance'
          booking_amount *= reference.amount - reference.balance
      end
    end

    booking_params['amount'] = booking_amount
    
    # Override by passed in parameters
    booking_params.merge!(params)
  end
  
  # Factory methods
  def build_booking(params = {})
    Booking.new(booking_parameters(params))
  end

  def create_booking(params = {})
    Booking.create(booking_parameters(params))
  end

  def self.build_booking(code, params = {})
    find_by_code(code).try(:build_booking, params)
  end

  def self.create_booking(code, params = {})
    find_by_code(code).try(:create_booking, params)
  end

  # Importer
  def self.import(struct)
    templates = self.all.inject([]) do |found, template|
      puts "matcher: " + template.matcher
      puts 'text: ' + struct.text
      found << template if not Regexp.new(template.matcher).match(struct.text).eql?nil
    end
    puts templates.inspect
  end
end
