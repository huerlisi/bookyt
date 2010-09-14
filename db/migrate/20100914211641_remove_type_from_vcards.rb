class RemoveTypeFromVcards < ActiveRecord::Migration
  def self.up
    remove_column :vcards, :type
  end

  def self.down
    add_column :vcards, :type, :string
  end
end
