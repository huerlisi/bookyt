class BookingTemplate < ActiveRecord::Base
  # Associations
  belongs_to :debit_account, :foreign_key => 'debit_account_id', :class_name => "Account"
  belongs_to :credit_account, :foreign_key => 'credit_account_id', :class_name => "Account"

  # Default ordering
  default_scope order(:code)

  # Scopes
  scope :by_type, lambda{|value| where("code LIKE ?", value + ':%')}

  # Standard methods
  include ApplicationHelper
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

  def amount_to_s
    if amount_relates_to.present?
      return "%.2f%%" % (amount.to_f * 100)
    else
      return currency_fmt(amount)
    end
  end

  def booking_parameters(params = {})
    params = HashWithIndifferentAccess.new(params)

    # Prepare parameters set by template
    booking_params = attributes.reject{|key, value| !["title", "comments", "credit_account_id", "debit_account_id"].include?(key)}

    # Calculate amount
    booking_amount = BigDecimal.new(self.amount.to_s || '0')

    # Lookup reference
    reference = params['reference']
    unless reference
      ref_type = params['reference_type']
      ref_id = params['reference_id']
      if ref_type.present? and ref_id.present?
        reference = ref_type.constantize.find(ref_id)
      end
    end

    person_id = params.delete(:person_id)

    if reference
      # Calculate amount
      booking_amount = amount(reference.value_date, :person_id => person_id) if person_id

      case self.amount_relates_to
        when 'reference_amount'
          booking_amount *= reference.amount unless reference.amount.nil?
        when 'reference_balance'
          booking_amount *= reference.balance unless reference.balance.nil?
        when 'reference_amount_minus_balance'
          booking_amount *= reference.amount - reference.balance unless (reference.amount.nil? or reference.balance.nil?)
      end
    end

    booking_amount = booking_amount.try(:round, 2)
    booking_params['amount'] = booking_amount
    booking_params['include_in_saldo'] = self.include_in_saldo

    # Override by passed in parameters
    HashWithIndifferentAccess.new(booking_params.merge!(params))
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

  # Tagging
  acts_as_taggable_on :include_in_saldo

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
