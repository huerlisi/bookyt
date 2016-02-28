class CreateDebitDirectFiles < ActiveRecord::Migration
  def change
    create_table :debit_direct_files do |t|
      t.text :content, null: false

      t.timestamps
    end

    add_column :invoices, :debit_direct_file_id, :integer, index: true
  end
end
