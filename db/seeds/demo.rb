# encoding: utf-8

# Demo Seed
# =========
# Tenant
tenant = Tenant.create!


# User
user_vcard = HasVcards::Vcard.new(:given_name => 'Peter', :family_name => 'Admin', :street_address => 'Gartenstr. 199c', :postal_code => '8888', :locality => 'Zürich')
user_person = Person.new(:vcard => user_vcard, :sex => Person::MALE)
user = User.new(
  :email => 'admin@example.com',
  :password => 'demo1234',
  :password_confirmation => 'demo1234',
  :person => user_person,
  :role_texts => ['admin']
)
user.tenant = tenant
user.save!

# Company
company_vcard = HasVcards::Vcard.new(:full_name => 'Beispiel GmbH', :street_address => 'Balkonweg 17', :postal_code => '8888', :locality => 'Zürich')
company = Company.create!(:vcard => company_vcard)

# Accounts
#bank = Bank.create!(
#  :full_name => "General Bank", :street_address => "Hauptstrasse 1", :postal_code => "8000", :locality => "Zürich"
#)

#BankAccount.create!(
#  :pc_id => "01-123456-7", :esr_id => "444444", :code => "1020", :title => "Bankkonto", :bank => bank, :holder => company
#)
