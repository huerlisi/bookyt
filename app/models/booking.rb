class Booking < ActiveRecord::Base
  include ApplicationHelper
  
  # Validations
  validates_presence_of :debit_account, :credit_account, :title, :amount, :value_date
  validates_date :value_date
  
  # Associations
  belongs_to :debit_account, :foreign_key => 'debit_account_id', :class_name => "Account"
  belongs_to :credit_account, :foreign_key => 'credit_account_id', :class_name => "Account"
  
  # Scoping
  default_scope order('value_date, id')

  scope :by_value_date, lambda {|value_date| where(:value_date => value_date) }
  scope :by_value_period, lambda {|from, to| where(:value_date => (from..to)) }
  
  scope :by_account, lambda {|account_id|
    { :conditions => ["debit_account_id = :account_id OR credit_account_id = :account_id", {:account_id => account_id}] }
  } do
    # Returns array of all booking titles.
    def titles
      find(:all, :group => :title).map{|booking| booking.title}
    end
    
    # Statistics per booking title.
    #
    # The statistics are an array of hashes with keys title, count, sum, average.
    def statistics
      find(:all, :select => "title, count(*) AS count, sum(amount) AS sum, avg(amount) AS avg", :group => :title).map{|stat| stat.attributes}
    end
  end

  scope :by_text, lambda {|value|
    text   = '%' + value + '%'
    
    amount = value.delete("'").to_f
    if amount == 0.0
      amount = nil unless value.match(/^[0.]*$/)
    end
    
    date   = nil
    begin
      date = Date.parse(value)
    rescue ArgumentError
    end
    
    where("title LIKE :text OR amount = :amount OR value_date = :value_date", :text => text, :amount => amount, :value_date => date)
  }
  
  # Returns array of all years we have bookings for
  def self.fiscal_years
    with_exclusive_scope do
      select("DISTINCT year(value_date) AS year").all.map{|booking| booking.year}
    end
  end

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

  # Helpers
  def accounted_amount(account)
    if credit_account == account
      return amount
    elsif debit_account == account
      return -(amount)
    else
      return 0.0
    end
  end

  def amount_as_string
    '%0.2f' % amount
  end
  
  def amount_as_string=(value)
    self.amount = value
  end
  
  def rounded_amount
    if amount.nil?
    	return 0
    else
    	return (amount * 20).round / 20.0
    end
  end

  # Templates
  def booking_template_id
    nil
  end
  
  def booking_template_id=(value)
    booking_template = BookingTemplate.find(value)
    
    booking_template_parameters = booking_template.booking_parameters
    booking_template_parameters.reject!{|key, value| value.blank?}

    # TODO: ensure association objects (accounts) get reloaded, too
    self.attributes = attributes.merge!(booking_template_parameters)
  end
  
  # Reference
  belongs_to :reference, :polymorphic => true
  after_save :notify_references

  scope :by_reference, lambda {|value| 
    where(:reference_id => value.id, :reference_type => value.class)
  } do
    def direct_balance(direct_account)
      balance = 0.0

      for booking in all
        balance += booking.accounted_amount(direct_account)
      end

      balance
    end
  end
  
  private
  def notify_references
    reference.booking_saved(self) if reference.respond_to?(:booking_saved)
  end
end
