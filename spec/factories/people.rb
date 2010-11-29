# Person factories

Factory.define :vcard do |f|
  f.given_name     'Peter'
  f.family_name    'Muster'
  f.street_address 'Teststr. 1'
  f.postal_code    '9999'
  f.locality       'Capital'
end

Factory.define :person do |f|
  f.vcard Factory.build(:vcard)
end
