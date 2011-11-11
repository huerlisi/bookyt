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

  factory :invoice_booking_template, :class => BookingTemplate do
    code              "credit_invoice:invoice"
    title             "Kreditoren Rechnung"
    amount            1
    comments          ""
    amount_relates_to "reference_amount"
    association :credit_account, :factory => :material_account
    association :debit_account, :factory => :credit_account
  end

  factory :invoice_without_amount_relates_to, :class => BookingTemplate do
    code              "credit_invoice:invoice"
    title             "Kreditoren Rechnung"
    amount            1
    comments          ""
    association :credit_account, :factory => :material_account
    association :debit_account, :factory => :credit_account
  end
end
