class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.references :customer
      t.references :company
      t.integer :due_date
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
  end
end
