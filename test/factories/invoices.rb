# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :invoice do |f|
  f.customer_id 1
  f.due_date 1
  f.state "MyString"
end
