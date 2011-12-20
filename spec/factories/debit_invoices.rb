# DebitInvoice factories

FactoryGirl.define do
  factory :debit_invoice do
    association :customer
    association :company
    title "DebitInvoice"
    state 'booked'
    value_date '2010-09-20'
    due_date '2010-10-20'
  end

  factory :open_debit_invoice, :class => DebitInvoice do
    association :customer
    association :company
    value_date '2010-09-20'
    due_date '2010-10-20'
    state 'booked'
    title "New Invoice"
  end

  factory :paid_debit_invoice, :class => DebitInvoice do
    association :customer
    association :company
    value_date '2010-09-20'
    due_date '2010-10-20'
    state 'paid'
    title "New Invoice"
  end

  factory :debit_invoice_booking, :class => Booking do
    title           "Lanna Thai"
    amount          20.25
    value_date      "2006-11-21"
    debit_currency  "CHF"
    credit_currency "CHF"
    exchange_rate   1.0

    association :credit_account, :factory => :debit_account
    association :debit_account, :factory => :food_account
  end

  factory :payment_booking, :class => Booking do
    title           "Lanna Thai"
    amount          20.25
    value_date      "2006-11-21"
    debit_currency  "CHF"
    credit_currency "CHF"
    exchange_rate   1.0

    association :credit_account, :factory => :bank_account
    association :debit_account, :factory => :debit_account
  end
end
