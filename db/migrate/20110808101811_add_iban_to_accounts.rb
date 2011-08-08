class AddIbanToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :iban, :string
  end
end
