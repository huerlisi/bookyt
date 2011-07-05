# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :asset do |f|
  f.title "MyString"
  f.remarks "MyText"
  f.amount "9.99"
  f.state "MyString"
end