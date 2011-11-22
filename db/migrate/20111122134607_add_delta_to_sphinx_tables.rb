class AddDeltaToSphinxTables < ActiveRecord::Migration
  def change
    add_column :people, :delta, :boolean, :default => true, :null => false
    add_column :invoices, :delta, :boolean, :default => true, :null => false
  end
end
