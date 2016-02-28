class AddDirectDebitEnabledToPeople < ActiveRecord::Migration
  def change
    add_column :people, :direct_debit_enabled, :boolean, default: false
  end
end
