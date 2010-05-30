class AddHasAccountsColumnsToAccounts < ActiveRecord::Migration
  def self.up
    # Add .code
    add_column :accounts, :code, :string
    add_index :accounts, :code
    Account.update_all "code = number"
    Account.update_all "number = NULL"
    
    # Single Table Inheritance
    add_column :accounts, :type, :integer
    add_index :accounts, :type

    # BankAccount support
    add_column :accounts, :holder_id, :integer
    add_column :accounts, :holder_type, :string
    add_index :accounts, [:holder_id, :holder_type]

    add_column :accounts, :bank_id, :integer
    add_index :accounts, :bank_id

    # ESR support
    add_column :accounts, :esr_id, :integer
    add_column :accounts, :pc_id, :integer
  end

  def self.down
    remove_columns :accounts, :pc_id
    remove_columns :accounts, :esr_id
    
    remove_columns :accounts, :bank_id
    remove_columns :accounts, :holder_id
    remove_columns :accounts, :holder_type
    
    remove_columns :accounts, :type
    
    Account.update_all "numer = code"
    remove_columns :accounts, :code
  end
end
