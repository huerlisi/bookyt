class AccountsCarryNoYear < ActiveRecord::Migration
  def self.up
    remove_column :accounts, :year
  end

  def self.down
    add_column :accounts, :year, :integer
  end
end
