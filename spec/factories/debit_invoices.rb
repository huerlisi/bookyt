# DebitInvoice factories

FactoryGirl.define do
  factory :debit_invoice do
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
end
