class UpdatePersonTypeEmployer < ActiveRecord::Migration
  def self.up
    Person.update_all("type = 'Company'", "type = 'Employer'")
  end

  def self.down
  end
end
