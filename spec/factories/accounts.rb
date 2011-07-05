FactoryGirl.define do
  factory :account do
    title 'Account'
    code '1000'
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
end
