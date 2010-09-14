class AddSexToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :sex, :integer
  end

  def self.down
    remove_column :people, :sex
  end
end
