class Booking < ActiveRecord::Base
  include ApplicationHelper
  
  # Associations
  belongs_to :debit_account, :foreign_key => 'debit_account_id', :class_name => "Account"
  belongs_to :credit_account, :foreign_key => 'credit_account_id', :class_name => "Account"
  
  # Validations
  validates_presence_of :debit_account, :credit_account, :title, :amount
  validates_date :value_date
  
  # Scoping
  default_scope order(:value_date)
  
  scope :by_text, lambda {|value| where("title LIKE ?", '%' + value + '%')}
  
  scope :by_value_date, lambda {|value_date| { :conditions => { :value_date => value_date } } }
  scope :by_value_period, lambda {|from, to| { :conditions => { :value_date => from..to } } }
  
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

  # Returns array of all years we have bookings for
  def self.fiscal_years
    with_exclusive_scope do
      select("DISTINCT year(value_date) AS year").all.map{|booking| booking.year}
    end
  end

#  file_column :scan

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
    '%0.2f' % (amount || 0.0)
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

  def value_date=(value)
    if value.is_a?(String)
      if value =~ /....-..-../
        write_attribute(:value_date, value)
      else
        day, month, year = value.split('.')
        month ||= Date.today.month
        year ||= Date.today.year
        year = 2000 + year.to_i if year.to_i < 100

        write_attribute(:value_date, "#{year}-#{month}-#{day}")
      end
    else
      write_attribute(:value_date, value)
    end
  end
end
