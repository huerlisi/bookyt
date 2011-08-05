# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :line_item do
      quantity "9.99"
      price "9.99"
      code "MyString"
      title "MyString"
      description "MyString"
      item nil
      type ""
      invoice nil
    end
end