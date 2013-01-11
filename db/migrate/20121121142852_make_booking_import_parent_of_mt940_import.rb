class MakeBookingImportParentOfMt940Import < ActiveRecord::Migration
  def up
    rename_table :mt940_imports, :booking_imports

    add_column :booking_imports, :type, :string
    add_index :booking_imports, :type

    BookingImport.reset_column_information
    BookingImport.update_all(:type => 'Mt940Import')
  end
end
