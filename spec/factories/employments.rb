FactoryGirl.define do
  factory :employment do
    duration_from Date.yesterday
    association :employee
    association :employer, :factory => :company
  end
end
