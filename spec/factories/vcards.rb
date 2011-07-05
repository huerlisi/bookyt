FactoryGirl.define do
  factory :vcard do
    given_name      'Peter'
    family_name     'Muster'
    street_address 'Teststr. 1'
    postal_code    '9999'
    locality       'Capital'
  end
end
