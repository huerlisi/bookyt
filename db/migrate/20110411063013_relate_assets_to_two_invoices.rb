class RelateAssetsToTwoInvoices < ActiveRecord::Migration
  def self.up
    rename_column :assets, :invoice_id, :purchase_invoice_id
    add_column :assets, :selling_invoice_id, :integer
  end

  def self.down
    remove_column :assets, :selling_invoice_id
    rename_column :assets, :purchase_invoice_id, :invoice_id
  end
end
