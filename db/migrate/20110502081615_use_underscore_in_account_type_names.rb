class UseUnderscoreInAccountTypeNames < ActiveRecord::Migration
  def self.up
    AccountType.all.map{|account_type|
      account_type.name = account_type.name.gsub(' ', '_')
      account_type.save
    }
  end

  def self.down
  end
end
