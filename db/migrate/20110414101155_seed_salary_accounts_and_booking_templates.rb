class SeedSalaryAccountsAndBookingTemplates < ActiveRecord::Migration
  def self.up
    Account.find_or_create_by_code(:code => "2020", :title => "Kreditoren Sozialversicherungen")
    Account.find_or_create_by_code(:code => "2050", :title => "Offene Lohnforderungen")
    Account.find_or_create_by_code(:code => "5000", :title => "Lohnaufwand")
    Account.find_or_create_by_code(:code => "5700", :title => "Sozialversicherungaufwand")
  end

  def self.down
  end
end
