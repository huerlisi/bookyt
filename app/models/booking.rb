class Booking < ActiveRecord::Base
  belongs_to :debit_account, :foreign_key => 'debit_account_id', :class_name => "Account"
  belongs_to :credit_account, :foreign_key => 'credit_account_id', :class_name => "Account"
  
  file_column :scan

  def rounded_amount
    if amount.nil?
    	return 0
    else
    	return (amount * 20).round / 20.0
    end
  end

  def in_place_amount
    sprintf("%.2f", self.amount)
  end
  
  def in_place_amount=(value)
    self.amount=value
  end
  
  def value_date=(value)
    if value.is_a?(String)
      day, month, year = value.split('.')
      month ||= Date.today.month
      year ||= Date.today.year
      year = 2000 + year.to_i if year.to_i < 100

      write_attribute(:value_date, "#{year}-#{month}-#{day}")
    else
      write_attribute(:value_date, value)
    end
  end

  def value_date_before_type_cast
    read_attribute(:value_date).strftime("%d.%m.%Y") unless read_attribute(:value_date).nil?
  end
end
