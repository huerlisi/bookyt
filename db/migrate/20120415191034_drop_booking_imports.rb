class DropBookingImports < ActiveRecord::Migration
  def up
    drop_table :booking_imports
  end
end
