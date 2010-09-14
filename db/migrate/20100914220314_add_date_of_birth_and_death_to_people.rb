class AddDateOfBirthAndDeathToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :date_of_birth, :date
    add_column :people, :date_of_death, :date
  end

  def self.down
    remove_column :people, :date_of_death
    remove_column :people, :date_of_birth
  end
end
