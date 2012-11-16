class DropTableNotes < ActiveRecord::Migration
  def up
    drop_table :notes
  end
end
