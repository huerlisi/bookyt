class BookingTemplate < ActiveRecord::Base
  # Associations
  belongs_to :debit_account, :foreign_key => 'debit_account_id', :class_name => "Account"
  belongs_to :credit_account, :foreign_key => 'credit_account_id', :class_name => "Account"

  # Standard methods
  def to_s(format = :default)
    case format
    when :short
      "%s / %s CHF %s" % [
        credit_account ? credit_account.code : '?',
        debit_account ? debit_account.code : '?',
        amount ? "%0.2f" % amount : '?',
      ]
    else
      "%s an %s CHF %s, %s (%s)" % [
        credit_account ? "#{credit_account.title} (#{credit_account.code})" : '?',
        debit_account ? "#{debit_account.title} (#{debit_account.code})" : '?',
        amount ? "%0.2f" % amount : '?',
        title.present? ? title : '?',
        comments.present? ? comments : '?'
      ]
    end
  end

  def build_booking(params = {})
    booking_params = attributes.reject{|key, value| !["title", "amount", "comments", "credit_account_id", "debit_account_id"].include?(key)}
    booking_params.merge!(params)

    Booking.new(booking_params)
  end

  def create_booking(params = {})
    booking = build_booking(params)
    booking.save
    
    booking
  end

  def self.create_booking(code, params = {})
    template = find_by_code(code)
    return if template.nil?
    
    template.create_booking(params)
  end

  def self.import(struct)
    templates = self.all.inject([]) do |found, template|
      puts "matcher: " + template.matcher
      puts 'text: ' + struct.text
      found << template if not Regexp.new(template.matcher).match(struct.text).eql?nil
    end
    puts templates.inspect
  end
end
