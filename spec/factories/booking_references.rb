# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :booking_reference do |f|
    f.booking_id 1
    f.kind "MyString"
  end
end
