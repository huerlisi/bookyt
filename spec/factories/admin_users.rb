FactoryGirl.define do
  factory :admin_user do
    sequence(:email) {|n| "admin#{n}@example.com" }
    password "user1234"
  end
end
