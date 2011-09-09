class AddTextToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :text, :text
  end
end
