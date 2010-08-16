# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
Account.create!([
  {:code => "1000", :title => "Kasse"},
  {:code => "1010", :title => "Kasse Laden"},
  {:code => "1021", :title => "EFT Kontokorrent"},
  {:code => "1100", :title => "Debitoren"},
  {:code => "2001", :title => "Ausstehende Gutscheine"},
  {:code => "3200", :title => "Dienstleistungsertrag"},
  {:code => "3900", :title => "Debitorenverlust"},
])

BookingTemplate.create!([
  {:code => "day:cash", :title => "Bareinnahmen", :debit_account => Account.where(:code => "3200").first, :credit_account => Account.where(:code => "1010").first},
  {:code => "day:card turnover", :title => "Kreditkarten Einnahmen", :debit_account => Account.where(:code => "3200").first, :credit_account => Account.where(:code => "1021").first},
  {:code => "day:expenses", :title => "Barausgabe", :debit_account => Account.where(:code => "1010").first, :credit_account => Account.where(:code => "1000").first},
  {:code => "day:credit turnover", :title => "Kredit", :debit_account => Account.where(:code => "3200").first, :credit_account => Account.where(:code => "1100").first},
  {:code => "day:voucher sold", :title => "Gutschein ausgestellt", :debit_account => Account.where(:code => "2001").first, :credit_account => Account.where(:code => "1010").first},
  {:code => "day:voucher cashed", :title => "Gutschein eingelöst", :debit_account => Account.where(:code => "3200").first, :credit_account => Account.where(:code => "2001").first},
])
