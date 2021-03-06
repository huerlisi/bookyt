# Role factories
FactoryGirl.define do
  factory :admin_role, :class => Role do
    name 'admin'
  end

  factory :accountant_role, :class => Role do
    name 'accountant'
  end

  factory :user_role, :class => Role do
    name 'accountant'
  end
end
