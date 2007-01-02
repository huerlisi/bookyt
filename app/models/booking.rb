class Booking < ActiveRecord::Base
  belongs_to :debit_account, :foreign_key => 'debit_account_id', :class_name => "Account"
  belongs_to :credit_account, :foreign_key => 'credit_account_id', :class_name => "Account"
  
  file_column :scan

  def rounded_amount
    (amount * 20).ceil / 20.0
  end
end
