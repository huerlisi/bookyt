class AddCachedAmountToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :amount, :decimal, :precision => 10, :scale => 2
    add_column :invoices, :due_amount, :decimal, :precision => 10, :scale => 2
  end
end
