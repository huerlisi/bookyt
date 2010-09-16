class AddTitleAndRemarksToInvoices < ActiveRecord::Migration
  def self.up
    add_column :invoices, :title, :string
    add_column :invoices, :remarks, :text
  end

  def self.down
    remove_column :invoices, :remarks
    remove_column :invoices, :title
  end
end
