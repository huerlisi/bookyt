# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :charge_rate do |f|
  f.code "MyString"
  f.rate "9.99"
  f.duration_from "2011-04-14"
  f.duration_to "2011-04-14"
end