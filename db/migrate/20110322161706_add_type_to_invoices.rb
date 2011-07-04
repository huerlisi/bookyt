class AddTypeToInvoices < ActiveRecord::Migration
  def self.up
    add_column :invoices, :type, :string

    Invoice.update_all(:type => 'DebitInvoice')
  end

  def self.down
    remove_column :invoices, :type
  end
end
