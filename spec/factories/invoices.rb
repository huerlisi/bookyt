# Invoice factories

FactoryGirl.define do
  factory :invoice do
    association :customer
    association :company
    value_date '2010-09-20'
    due_date '2010-10-20'
    state "new"
    title "New Invoice"
  end

  factory :credit_invoice do
  end
end
