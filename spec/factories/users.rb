FactoryGirl.define do
  factory :user do
    email    { Factory.next(:email) }
    password "user1234"
    person
    roles {|roles| [roles.association :user_role] }
    association :tenant
  end

  factory :accountant_user, :class => User do
    email    { Factory.next(:email) }
    password "admin1234"
    person
    roles {|roles| [roles.association :accountant_role] }
    association :tenant
  end

  factory :admin_user, :class => User do
    email    { Factory.next(:email) }
    password "admin1234"
    person
    roles {|roles| [roles.association :admin_role] }
    association :tenant
  end

  Factory.sequence :email do |n|
     names = %w[ joe bob sue amanda ]
     # randomly select a name from the names array for the email, so you might get "Bob1@somewhere.com"
     "#{names[rand 4]}#{n}@example.com"
  end
end
