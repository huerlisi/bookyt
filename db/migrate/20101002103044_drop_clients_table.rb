class DropClientsTable < ActiveRecord::Migration
  def self.up
    drop_table :clients
  end

  def self.down
  end
end
