# Employee factories

FactoryGirl.define do
  factory :person_vcard do
    vcard
  end

  factory :employee, :parent => :person_vcard, :class => Employee do
  end
end
