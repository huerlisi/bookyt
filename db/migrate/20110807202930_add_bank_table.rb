class AddBankTable < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.belongs_to  "vcard"

      t.timestamps
    end

    add_index :banks, :vcard_id
  end
end
