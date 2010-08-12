# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
Account.create!([
  {:code => "1000", :title => "Kasse"},
  {:code => "1100", :title => "Debitoren"},
  {:code => "1210", :title => "Lager Medikamente"},
  {:code => "3200", :title => "Dienstleistungsertrag"},
  {:code => "3900", :title => "Debitorenverlust"},
  {:code => "4000", :title => "Aufwand Medikamente"},
])
