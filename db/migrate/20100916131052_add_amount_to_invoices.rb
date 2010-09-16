class AddAmountToInvoices < ActiveRecord::Migration
  def self.up
    add_column :invoices, :amount, :decimal
  end

  def self.down
    remove_column :invoices, :amount
  end
end
