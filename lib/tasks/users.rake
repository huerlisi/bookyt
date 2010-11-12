def ask message
  print message
  STDIN.gets.chomp
end

namespace :users do
  desc "Creates an admin user"
  task :admin => :environment do
    email = ask('email: ')
    password = ask('password (at least 6 chars): ')
    user = User.create({:email => email, :password => password, :password_confirmation => password})
    if user.valid?
      user.roles.create(:name => 'admin')
    else
      user.errors.each do |error|
        puts error
      end
    end
  end
end
