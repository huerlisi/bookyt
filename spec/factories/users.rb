FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password "user1234"
    person
    roles {|roles| [roles.association(:user_role)] }
    association :tenant

    factory :user_accountant, :class => User do
      roles {|roles| [roles.association(:accountant_role)] }
    end

    factory :user_admin, :class => User do
      roles {|roles| [roles.association(:admin_role)] }
    end
  end
end
