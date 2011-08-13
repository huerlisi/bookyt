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

    # Create user
    user = User.create({:email => email, :password => password, :password_confirmation => password})
    if user.invalid?
      puts "[Error] creating user:"
      user.errors.each do |error|
        puts error
      end

      exit 1
    end

    # Assign admin role
    user.role_texts = ['admin']
  end
end
