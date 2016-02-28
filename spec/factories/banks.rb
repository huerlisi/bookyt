# Bank factories
FactoryGirl.define do
  factory :bank do
    vcard
    clearing 1337
  end
end
