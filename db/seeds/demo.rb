# Demo Seed
# =========

# User
user_vcard = Vcard.new(:given_name => 'Peter', :family_name => 'Admin', :street_address => 'Freedomroad 19', :postal_code => '9999', :locality => 'Capital')
user_person = Person.new(:vcard => user_vcard, :sex => Person::MALE)
user = User.new(:email => 'admin@example.com', :password => 'demo1234', :password_confirmation => 'demo1234')
user.person = user_person
user.save
user.roles.create(:name => 'admin')

# Company
company_vcard = Vcard.new(:full_name => 'Example Inc.', :street_address => 'Mainstreet 17', :postal_code => '9999', :locality => 'Capital')
company = Company.create(:vcard => company_vcard)

# Tenant
user.create_tenant(:company => company)
user.save
