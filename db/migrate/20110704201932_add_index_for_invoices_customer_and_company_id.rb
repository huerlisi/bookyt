class AddIndexForInvoicesCustomerAndCompanyId < ActiveRecord::Migration
  def self.up
    add_index :invoices, :company_id
    add_index :invoices, :customer_id
  end

  def self.down
#    remove_index :invoices, :company_id
#    remove_index :invoices, :customer_id
  end
end
