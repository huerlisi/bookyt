# Customer factories
FactoryGirl.define do
  factory :customer do
    vcard

    trait :direct_debit do
      direct_debit_enabled true
      clearing '1234'
      bank_account 'greedy-123.4'
    end
  end
end
