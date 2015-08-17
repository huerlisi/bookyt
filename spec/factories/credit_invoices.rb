# CreditInvoice factories

FactoryGirl.define do
  factory :credit_invoice do
    association :customer
    association :company
    title "CreditInvoice"
    state 'booked'
    value_date '2010-09-20'
    due_date '2010-10-20'
  end
end

