def ask message
  print message
  STDIN.gets.chomp
end

namespace :users do
  desc "Creates an admin user"
  task :admin => :environment do

    # Ask for credentials
    puts "Please give admin credentials:"
    email = ask('Email: ')
    password = ask('Password (at least 6 chars): ')
    given_name = ask('Given name: ')
    family_name = ask('Family name: ')
    person = Person.create(:vcard => Vcard.new(:given_name => given_name, :family_name => family_name))

    # Create user
    user = User.create({
      :email    => email,
      :password => password,
      :person   => person
    })

    if user.invalid?
      puts "[Error] creating user:"
      user.errors.each do |error|
        puts error
      end

      exit 1
    end

    # Assign admin role
    user.role_texts = ['admin']

    # Create Company
    puts "Please give company credentials:"
    full_name = ask('Name: ')
    company = Company.create(:vcard => Vcard.new(:full_name => full_name))

    # Create tenant
    tenant = Tenant.create(:company => company, :incorporated_on => Date.today, :fiscal_year_ends_on => Date.today.end_of_year)
    tenant.users << user
  end
end
