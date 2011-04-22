class AddDurationToInvoices < ActiveRecord::Migration
  def self.up
    add_column :invoices, :duration_from, :date
    add_column :invoices, :duration_to, :date
  end

  def self.down
    remove_column :invoices, :duration_to
    remove_column :invoices, :duration_from
  end
end
