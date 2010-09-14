class AddTypeToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :type, :string
  end

  def self.down
    remove_column :people, :type
  end
end
