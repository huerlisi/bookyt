# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
Account.create!([
  {:code => "1000", :title => "Kasse"},
  {:code => "1010", :title => "Kasse Laden"},
  {:code => "1020", :title => "Bankkonto"},
  {:code => "1021", :title => "EFT Kontokorrent"},
  {:code => "1100", :title => "Debitoren"},
  {:code => "2001", :title => "Ausstehende Gutscheine"},
  {:code => "3200", :title => "Dienstleistungsertrag"},
])

# Booking Templates
# =================
# Day
BookingTemplate.create!([
  {:code => "day:cash", :title => "Bareinnahmen", :debit_account => Account.find_by_code(:code => "3200"), :credit_account => Account.find_by_code(:code => "1010")},
  {:code => "day:card turnover", :title => "Kreditkarten Einnahmen", :debit_account => Account.find_by_code(:code => "3200"), :credit_account => Account.find_by_code(:code => "1021")},
  {:code => "day:expenses", :title => "Barausgabe", :debit_account => Account.find_by_code(:code => "1010"), :credit_account => Account.find_by_code(:code => "1000")},
  {:code => "day:credit turnover", :title => "Kredit", :debit_account => Account.find_by_code(:code => "3200"), :credit_account => Account.find_by_code(:code => "1100")},
  {:code => "day:voucher sold", :title => "Gutschein ausgestellt", :debit_account => Account.find_by_code(:code => "2001"), :credit_account => Account.find_by_code(:code => "1010")},
  {:code => "day:voucher cashed", :title => "Gutschein eingelöst", :debit_account => Account.find_by_code(:code => "3200"), :credit_account => Account.find_by_code(:code => "2001")},
])

# CreditInvoice
Account.create!([
  {:code => "2000", :title => "Kreditoren"},
  {:code => "4000", :title => "Materialaufwand"},
])

BookingTemplate.create!([
  {:code => "credit_invoice:invoice", :title => "Kreditoren Rechnung", :debit_account => Account.find_by_code("2000"), :credit_account => Account.find_by_code("4000"), :amount => 1, :amount_relates_to => 'reference_amount'},
  {:code => "credit_invoice:reminder", :title => "Mahnung", :debit_account => Account.find_by_code("2000"), :credit_account => Account.find_by_code("4000")},
  {:code => "credit_invoice:cancel", :title => "Storno", :debit_account => Account.find_by_code("4000"), :credit_account => Account.find_by_code("2000"), :amount => 1, :amount_relates_to => 'reference_amount'},

  {:code => "credit_invoice:cash_payment", :title => "Barzahlung", :debit_account => Account.find_by_code("1000"), :credit_account => Account.find_by_code("2000"), :amount => 1, :amount_relates_to => 'reference_balance'},
  {:code => "credit_invoice:bank_payment", :title => "Bankzahlung", :debit_account => Account.find_by_code("1020"), :credit_account => Account.find_by_code("2000")},
])

# DebitInvoice
Account.create!([
  {:code => "3900", :title => "Debitorenverlust"},
])

BookingTemplate.create!([
  {:code => "debit_invoice:invoice", :title => "Debitoren Rechnung", :debit_account => Account.find_by_code("3200"), :credit_account => Account.find_by_code("1100"), :amount => 1, :amount_relates_to => 'reference_amount'},
  {:code => "debit_invoice:reminder", :title => "Mahnung", :debit_account => Account.find_by_code("3200"), :credit_account => Account.find_by_code("1100")},
  {:code => "debit_invoice:cancel", :title => "Storno", :debit_account => Account.find_by_code("1100"), :credit_account => Account.find_by_code("3200"), :amount => 1, :amount_relates_to => 'reference_amount'},

  {:code => "debit_invoice:cash_payment", :title => "Barzahlung", :debit_account => Account.find_by_code("1100"), :credit_account => Account.find_by_code("1000"), :amount => 1, :amount_relates_to => 'reference_balance'},
  {:code => "debit_invoice:bank_payment", :title => "Bankzahlung", :debit_account => Account.find_by_code("1100"), :credit_account => Account.find_by_code("1020")},
])

# Salaries
# ========
# Charge Rates
ChargeRate.create!([
  {:code => 'salary:both:ahv_iv_eo', :title => "AHV/IV/EO", :duration_from => '2007-01-01', :rate => 5.05},
  {:code => 'salary:both:ahv_iv_eo', :title => "AHV/IV/EO", :duration_from => '2011-01-01', :rate => 5.15},
  {:code => 'salary:both:alv', :title => "ALV", :duration_from => '2007-01-01', :rate => 1},
  {:code => 'salary:both:alv', :title => "ALV", :duration_from => '2011-01-01', :rate => 1.1},
  {:code => 'salary:both:alv_solidarity', :title => "ALV Solidaritätsprozent", :duration_from => '2011-01-01', :rate => 1},
])

# Accounts
Account.create!([
  {:code => "2020", :title => "Kreditoren Sozialversicherungen"},
  {:code => "2050", :title => "Offene Lohnforderungen"},
  {:code => "5000", :title => "Lohnaufwand"},
  {:code => "5700", :title => "Sozialversicherungaufwand"},
])

# Booking Templates
BookingTemplate.create!([
  {:code => "salary:invoice", :title => "Lohn", :debit_account => Account.find_by_code("2050"), :credit_account => Account.find_by_code("5000"), :amount => 1, :amount_relates_to => 'reference_amount'},
  {:code => "salary:cancel", :title => "Storno", :debit_account => Account.find_by_code("5000"), :credit_account => Account.find_by_code("2050"), :amount => 1, :amount_relates_to => 'reference_amount'},

  {:code => "salary:cash_payment", :title => "Barzahlung Lohn", :debit_account => Account.find_by_code("1000"), :credit_account => Account.find_by_code("2050"), :amount => 1, :amount_relates_to => 'reference_balance'},
  {:code => "salary:bank_payment", :title => "Bankzahlung Lohn", :debit_account => Account.find_by_code("1020"), :credit_account => Account.find_by_code("2050")},
])

ChargeBookingTemplate.create!([
  {:code => "salary:employee:ahv_iv_eo", :charge_rate => ChargeRate.find_by_code('salary:both:ahv_iv_eo'), :title => "AHV/IV/EO Arbeitnehmer", :debit_account => Account.find_by_code("2020"), :credit_account => Account.find_by_code("5000"), :amount_relates_to => 'reference_amount'},
  {:code => "salary:employer:ahv_iv_eo", :charge_code => ChargeRate.find_by_code('salary:both:ahv_iv_eo'), :title => "AHV/IV/EO Arbeitgeber", :debit_account => Account.find_by_code("2020"), :credit_account => Account.find_by_code("5700"), :amount_relates_to => 'reference_amount'},
])

# Asset
BookingTemplate.create!([
  {:code => "asset:activate", :title => "Aktivierung", :debit_account => Account.find_by_code("4000"), :credit_account => Account.find_by_code("1230"), :amount => 1, :amount_relates_to => 'reference_amount'},

  {:code => "asset:deprecation", :title => "Abschreibung linear 10%", :debit_account => Account.find_by_code("1230"), :credit_account => Account.find_by_code("6900"), :amount => 0.1, :amount_relates_to => 'reference_amount'},
])
