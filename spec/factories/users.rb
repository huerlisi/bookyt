FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password "user1234"
    person
    roles {|roles| [roles.association(:user_role)] }
    association :tenant

    factory :accountant_user, :class => User do
      roles {|roles| [roles.association(:accountant_role)] }
    end

    factory :admin_user, :class => User do
      roles {|roles| [roles.association(:admin_role)] }
    end
  end
end
