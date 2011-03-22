class AddValueDateToInvoices < ActiveRecord::Migration
  def self.up
    add_column :invoices, :value_date, :date

    Invoice.update_all('value_date = created_at')
  end

  def self.down
    remove_column :invoices, :value_date
  end
end
