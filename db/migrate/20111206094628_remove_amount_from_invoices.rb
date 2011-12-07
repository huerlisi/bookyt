class RemoveAmountFromInvoices < ActiveRecord::Migration
  def up
    remove_column :invoices, :amount
  end

  def down
    add_column :invoices, :amount, :decimal, :scope => 2
  end
end
