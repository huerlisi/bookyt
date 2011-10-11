FactoryGirl.define do
  factory :user_role, :class => Role do
    name 'user'
  end

  factory :admin_role, :class => Role do
    name 'admin'
  end

  factory :user do
    email    "user@example.com"
    password "user1234"
    association :user_role
    person
  end

  factory :admin_user, :class => User do
    email    "admin@example.com"
    password "admin1234"
    association :admin_role
    person
  end
end
