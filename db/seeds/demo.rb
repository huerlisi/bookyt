# Demo Seed
# =========

# User
user_vcard = Vcard.new(:given_name => 'Peter', :family_name => 'Admin', :street_address => 'Gartenstr. 199c', :postal_code => '8888', :locality => 'Zürich')
user_person = Person.new(:vcard => user_vcard, :sex => Person::MALE)
user = User.new(:email => 'admin@example.com', :password => 'demo1234', :password_confirmation => 'demo1234')
user.person = user_person
user.save
user.roles.create(:name => 'admin')

# Company
company_vcard = Vcard.new(:full_name => 'Beispiel GmbH', :street_address => 'Balkonweg 17', :postal_code => '8888', :locality => 'Zürich')
company = Company.create(:vcard => company_vcard)

# Tenant
user.create_tenant(
  :company => company,
  :incorporated_on => '2009-06-01',
  :fiscal_year_ends_on => '2009-12-31'
)
user.save

# Accounts
#bank = Bank.create!(
#  :full_name => "General Bank", :street_address => "Hauptstrasse 1", :postal_code => "8000", :locality => "Zürich"
#)

#BankAccount.create!(
#  :pc_id => "01-123456-7", :esr_id => "444444", :code => "1020", :title => "Bankkonto", :bank => bank, :holder => company
#)
