class RemoveClientIdFromAccounts < ActiveRecord::Migration
  def self.up
    remove_column :accounts, :client_id
  end

  def self.down
    add_column :accounts, :client_id, :integer
  end
end
