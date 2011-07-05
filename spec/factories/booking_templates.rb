FactoryGirl.define do
  factory :booking_template do
    factory :cash do
      title 'Bareinnahmen'
      association :credit_account, :factory => :cash_account
      association :debit_account, :factory => :service_account
      code 'day:cash'
      matcher '[B|b]arein[z|Z]ahlung'
    end

    factory :card_turnover do
      title 'Kreditkarten Einnahmen'
      association :credit_account, :factory => :eft_account
      association :debit_account, :factory => :service_account
      code 'day:card turnover'
      matcher 'test'
    end
  end
end
