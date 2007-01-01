class AddAccountNumber < ActiveRecord::Migration
  def self.up
    add_column :accounts, "number", :integer
  end

  def self.down
    remove_column :account, "number"
  end
end
