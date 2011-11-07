FactoryGirl.define do
  factory :user do
    email    "user@example.com"
    password "user1234"
    person
    roles {|roles| [roles.association :user_role] }
  end

  factory :admin_user, :class => User do
    email    "admin@example.com"
    password "admin1234"
    person
    roles {|roles| [roles.association :admin_role] }
  end
end
