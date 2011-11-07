FactoryGirl.define do
  factory :tenant do
    incorporated_on Date.today
    fiscal_year_ends_on Date.today
    association :company
  end
end

