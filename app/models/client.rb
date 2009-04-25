class Client < ActiveRecord::Base
  has_many :accounts

  has_many :current_assets, :class_name => 'Account', :conditions => 'account_type_id = 1', :order => 'number'
  has_many :capital_assets, :class_name => 'Account', :conditions => 'account_type_id = 2', :order => 'number'
  has_many :outside_capital, :class_name => 'Account', :conditions => 'account_type_id = 3', :order => 'number'
  has_many :equity_capital, :class_name => 'Account', :conditions => 'account_type_id = 4', :order => 'number'
  has_many :expenses, :class_name => 'Account', :conditions => 'account_type_id = 5', :order => 'number'
  has_many :earnings, :class_name => 'Account', :conditions => 'account_type_id = 6', :order => 'number'

  def saldo(type)
    new_saldo = 0

    for account in send(type)
      new_saldo += account.saldo
    end

    return new_saldo
  end
end
