# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :booking_reference do |f|
  f.booking_id 1
  f.kind "MyString"
end