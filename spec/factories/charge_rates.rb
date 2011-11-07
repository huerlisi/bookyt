# Charge rates factory
FactoryGirl.define do
  factory :charge_rate do
    code "MyString"
    title "Title"
    rate "9.99"
    duration_from "2011-04-14"
    duration_to "2011-04-14"
  end
end
