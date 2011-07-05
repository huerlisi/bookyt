FactoryGirl.define do
  factory :user do
    email    "user@example.com"
    password "user1234"
    roles [FactoryGirl.create(:role, :name => 'user')]
    person
  end

  factory :admin_user, :class => User do
    email    "admin@example.com"
    password "admin1234"
    roles [FactoryGirl.create(:role, :name => 'admin')]
    person
  end
end
