class AddSocialSecurityNumbersToEmployees < ActiveRecord::Migration
  def self.up
    add_column :people, :social_security_nr, :string
    add_column :people, :social_security_nr_12, :string
  end

  def self.down
    remove_column :people, :social_security_nr_12
    remove_column :people, :social_security_nr
  end
end
