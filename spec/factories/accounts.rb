FactoryGirl.define do
  factory :account do
    title 'Account'
    code '1000'
    association :account_type, :factory => :current_assets
  end

  factory :cash_account, :class => Account do
    title 'Kasse Laden'
    code '1010'
    association :account_type, :factory => :current_assets
  end

  factory :eft_account, :class => Account do
    title 'EFT Kontokorrent'
    code '1021'
    association :account_type, :factory => :current_assets
  end

  factory :service_account, :class => Account do
    title 'Dienstleistungsertrag'
    code '3200'
    association :account_type, :factory => :earnings
  end

  factory :material_account, :class => Account do
    title "Materialaufwand"
    code  "4000"
    association :account_type, :factory => :costs
  end

  factory :food_account, :class => Account do
    title "Verpflegung"
    code  "6701"
    association :account_type, :factory => :costs
  end

  factory :credit_account, :class => Account do
    title "Kreditoren"
    code  "2000"
    association :account_type, :factory => :outside_capital
  end

  factory :account_1100, :class => Account do
    title 'direct account'
    code '1100'
    association :account_type, :factory => :current_assets
  end
end
