class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.column "title",           :string,  :limit => 100
      t.column "saldo",           :integer
      t.column "client_id",       :integer
      t.column "parent_id",       :integer
      t.column "account_type_id", :integer
      t.column "year",            :integer
    end
  end

  def self.down
    drop_table :accounts
  end
end
