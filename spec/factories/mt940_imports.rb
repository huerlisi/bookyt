# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mt940_import do
    start_date "2012-11-19"
    end_date "2012-11-19"
    reference "MyString"
    mt940_attachment_id 1
    account_id 1
  end
end
