class AddBankAccountToPeople < ActiveRecord::Migration
  def change
    add_column :people, :bank_account, :string
  end
end
