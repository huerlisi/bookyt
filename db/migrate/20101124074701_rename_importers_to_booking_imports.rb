class RenameImportersToBookingImports < ActiveRecord::Migration
  def self.up
    rename_table :importers, :booking_imports
  end

  def self.down
    rename_table :booking_imports, :importers
  end
end
