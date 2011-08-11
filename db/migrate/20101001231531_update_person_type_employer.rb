class UpdatePersonTypeEmployer < ActiveRecord::Migration
  def self.up
    Person.unscoped.update_all("type = 'Company'", "type = 'Employer'")
  end

  def self.down
  end
end
