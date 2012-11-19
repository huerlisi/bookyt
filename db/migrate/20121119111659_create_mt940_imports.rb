class CreateMt940Imports < ActiveRecord::Migration
  def change
    create_table :mt940_imports do |t|
      t.date :start_date
      t.date :end_date
      t.string :reference
      t.integer :mt940_attachment_id
      t.integer :account_id

      t.timestamps
    end

    add_index :mt940_imports, :mt940_attachment_id
    add_index :mt940_imports, :account_id
  end
end
