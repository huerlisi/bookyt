# Demo Seed
# =========

# User
user = User.create(:email => 'admin@example.com', :password => 'demo1234', :password_confirmation => 'demo1234')
user.roles.create(:name => 'admin')

# Company
company_vcard = Vcard.new(:full_name => 'Example Inc.', :street_address => 'Mainstreet 17', :postal_code => '9999', :locality => 'Capital')
company = Company.create(:vcard => company_vcard)

# Tenant
user.create_tenant(:company => company)
