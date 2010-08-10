class Booking < ActiveRecord::Base
  include ApplicationHelper
  
  # Associations
  belongs_to :debit_account, :foreign_key => 'debit_account_id', :class_name => "Account"
  belongs_to :credit_account, :foreign_key => 'credit_account_id', :class_name => "Account"
  
  # Validations
  validates_presence_of :debit_account, :credit_account, :title, :amount
  validates_date :value_date
  
  # Scoping
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

#  file_column :scan

  # Standard methods
  def to_s(format = :default)
    case format
    when :short
      "#{value_date.strftime('%d.%m.%Y')}: #{credit_account.code} / #{debit_account.code} CHF #{amount_as_string} "
    else
      "#{value_date.strftime('%d.%m.%Y')}: #{credit_account.title} (#{credit_account.code}) an #{debit_account.title} (#{debit_account.code}) CHF #{amount_as_string}, #{title} " +
        (comments.blank? ? "" :"(#{comments})")
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

  def in_place_amount
    currency_fmt(self.rounded_amount)
  end
  
  def in_place_amount=(value)
    self.amount=value
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

  def in_place_value_date
    (value_date.nil?) ? ("&nbsp" * 5) : value_date.strftime("%d.%m.%Y")
  end
        
  def in_place_value_date=(value)
    self.value_date = value #write_attribute(:value_date, value)
  end
  
  def value_date_before_type_cast
    read_attribute(:value_date).strftime("%d.%m.%Y") unless read_attribute(:value_date).nil?
  end
end
