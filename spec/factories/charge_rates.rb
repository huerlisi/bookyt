# Charge rates factory
FactoryGirl.define do
  factory :charge_rate do
    code "MyString"
    title "Title"
    rate "9.99"
    duration_from "2011-04-14"
    duration_to nil
    association :person
  end

  factory :vat_rate, :class => ChargeRate do
    code "vat:normal"
    title "MWSt."
    rate "8.7"
    duration_from "2011-11-11"
    duration_to nil
  end
end
