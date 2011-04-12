class AddCodeToInvoices < ActiveRecord::Migration
  def self.up
    add_column :invoices, :code, :string
  end

  def self.down
    remove_column :invoices, :code
  end
end
