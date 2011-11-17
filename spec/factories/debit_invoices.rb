# DebitInvoice factories

FactoryGirl.define do
  factory :debit_invoice do
    association :customer
    association :company
    title "DebitInvoice"
    state 'open'
    amount 99.85
  end

  factory :open_debit_invoice, :class => DebitInvoice do
    association :customer
    association :company
    value_date '2010-09-20'
    due_date '2010-10-20'
    state 'booked'
    title "New Invoice"
    amount 99.85
  end

  factory :paid_debit_invoice, :class => DebitInvoice do
    association :customer
    association :company
    value_date '2010-09-20'
    due_date '2010-10-20'
    state 'paid'
    title "New Invoice"
    amount 99.85
  end

  factory :booked_booking, :class => Booking do
    title           "Lanna Thai"
    amount          20.25
    value_date      "2006-11-21"
    debit_currency  "CHF"
    credit_currency "CHF"
    exchange_rate   1.0
    
    association :credit_account, :factory => :food_account
    association :debit_account, :factory => :cash_account
  end

  factory :paid_booking, :class => Booking do
    title           "Lanna Thai"
    amount          0.0
    value_date      "2006-11-21"
    debit_currency  "CHF"
    credit_currency "CHF"
    exchange_rate   1.0
    
    association :credit_account, :factory => :food_account
    association :debit_account, :factory => :cash_account
  end
end
