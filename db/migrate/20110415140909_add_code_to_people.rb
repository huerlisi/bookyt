class AddCodeToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :code, :string
  end

  def self.down
    remove_column :people, :code
  end
end
