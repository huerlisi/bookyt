# Authorization
# =============
Role.create!([
  {:name => 'admin'},
  {:name => 'accountant'}
])

# Account Types
# =============
current_assets, capital_assets, outside_capital, equity_capital, costs, earnings =
AccountType.create!([
  {:name => "current_assets", :title => "Umlaufvermögen"},
  {:name => "capital_assets", :title => "Anlagevermögen"},
  {:name => "outside_capital", :title => "Fremdkapital"},
  {:name => "equity_capital", :title => "Eigenkapital"},
  {:name => "costs", :title => "Aufwand"},
  {:name => "earnings", :title => "Ertrag"},
])

Account.create!([
  {:code => "1000", :title => "Kasse", :account_type => current_assets},
  {:code => "1010", :title => "Kasse Laden", :account_type => current_assets},
  {:code => "1020", :title => "Bankkonto", :account_type => current_assets},
  {:code => "1021", :title => "EFT Kontokorrent", :account_type => current_assets},
  {:code => "1100", :title => "Debitoren", :account_type => current_assets},
  {:code => "2001", :title => "Ausstehende Gutscheine", :account_type => outside_capital},
  {:code => "3200", :title => "Dienstleistungsertrag", :account_type => earnings},
])

# Booking Templates
# =================
# Day
BookingTemplate.create!([
  {:code => "day:cash", :title => "Bareinnahmen", :debit_account => Account.find_by_code("3200"), :credit_account => Account.find_by_code("1010")},
  {:code => "day:card turnover", :title => "Kreditkarten Einnahmen", :debit_account => Account.find_by_code("3200"), :credit_account => Account.find_by_code("1021")},
  {:code => "day:expenses", :title => "Barausgabe", :debit_account => Account.find_by_code("1010"), :credit_account => Account.find_by_code("1000")},
  {:code => "day:credit turnover", :title => "Kredit", :debit_account => Account.find_by_code("3200"), :credit_account => Account.find_by_code("1100")},
  {:code => "day:voucher sold", :title => "Gutschein ausgestellt", :debit_account => Account.find_by_code("2001"), :credit_account => Account.find_by_code("1010")},
  {:code => "day:voucher cashed", :title => "Gutschein eingelöst", :debit_account => Account.find_by_code("3200"), :credit_account => Account.find_by_code("2001")},
])

# CreditInvoice
Account.create!([
  {:code => "2000", :title => "Kreditoren", :account_type => outside_capital},
  {:code => "4000", :title => "Materialaufwand", :account_type => costs},
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
  {:code => "3900", :title => "Debitorenverlust", :account_type => costs},
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
# Accounts
Account.create!([
  {:code => "2020", :title => "Kreditoren Sozialversicherungen", :account_type => outside_capital},
  {:code => "2050", :title => "Offene Lohnforderungen", :account_type => outside_capital},
  {:code => "5000", :title => "Lohnaufwand", :account_type => costs},
  {:code => "5700", :title => "Sozialversicherungaufwand", :account_type => costs},
])

# Booking Templates
BookingTemplate.create!([
  {:code => "salary:invoice", :title => "Lohn", :debit_account => Account.find_by_code("2050"), :credit_account => Account.find_by_code("5000"), :amount => 1, :amount_relates_to => 'reference_amount'},
  {:code => "salary:cancel", :title => "Storno", :debit_account => Account.find_by_code("5000"), :credit_account => Account.find_by_code("2050"), :amount => 1, :amount_relates_to => 'reference_amount'},

  {:code => "salary:cash_payment", :title => "Barzahlung Lohn", :debit_account => Account.find_by_code("1000"), :credit_account => Account.find_by_code("2050"), :amount => 1, :amount_relates_to => 'reference_balance'},
  {:code => "salary:bank_payment", :title => "Bankzahlung Lohn", :debit_account => Account.find_by_code("1020"), :credit_account => Account.find_by_code("2050")},
])

# Charge Rates
ChargeRate.create!([
  {:code => 'salary:both:ahv_iv_eo', :title => "AHV/IV/EO", :duration_from => '2007-01-01', :rate => 5.05},
  {:code => 'salary:both:ahv_iv_eo', :title => "AHV/IV/EO", :duration_from => '2011-01-01', :rate => 5.15},

  {:code => 'salary:both:alv', :title => "ALV", :duration_from => '2007-01-01', :rate => 1},
  {:code => 'salary:both:alv', :title => "ALV", :duration_from => '2011-01-01', :rate => 1.1},

  {:code => 'salary:both:alv_solidarity', :title => "ALV Solidaritätsprozent", :duration_from => '2011-01-01', :rate => 1},

  {:code => 'salary:employer:bu', :title => "BU", :duration_from => '2007-01-01', :duration_to => '2014-01-01', :rate => 0.071},

  {:code => 'salary:employee:nbu', :title => "NBU", :duration_from => '2010-07-01', :duration_to => '2014-01-01', :rate => 0.951},
  {:code => 'salary:employer:nbu', :title => "NBU", :duration_from => '2010-07-01', :duration_to => '2014-01-01', :rate => 0},

  {:code => 'salary:employer:fak', :title => "FAK", :duration_from => '2007-01-01', :rate => 1.6},
  {:code => 'salary:employer:fak', :title => "FAK", :duration_from => '2010-01-01', :rate => 1.4},

  {:code => 'salary:employer:vkb', :title => "VKB", :duration_from => '2007-01-01', :rate => 3 * 0.101},
  {:code => 'salary:employer:vkb', :title => "VKB", :duration_from => '2011-01-01', :rate => 3 * 0.13},
])

ChargeBookingTemplate.create!([
  {:code => "salary:employee:ahv_iv_eo", :charge_rate_code => 'salary:both:ahv_iv_eo', :title => "AHV/IV/EO Arbeitnehmer", :debit_account => Account.find_by_code("2020"), :credit_account => Account.find_by_code("5000"), :amount_relates_to => 'reference_amount'},
  {:code => "salary:employer:ahv_iv_eo", :charge_rate_code => 'salary:both:ahv_iv_eo', :title => "AHV/IV/EO Arbeitgeber", :debit_account => Account.find_by_code("2020"), :credit_account => Account.find_by_code("5700"), :amount_relates_to => 'reference_amount'},

  {:code => "salary:employee:alv", :charge_rate_code => 'salary:both:alv', :title => "ALV Arbeitnehmer", :debit_account => Account.find_by_code("2020"), :credit_account => Account.find_by_code("5000"), :amount_relates_to => 'reference_amount'},
  {:code => "salary:employer:alv", :charge_rate_code => 'salary:both:alv', :title => "ALV Arbeitgeber", :debit_account => Account.find_by_code("2020"), :credit_account => Account.find_by_code("5700"), :amount_relates_to => 'reference_amount'},

  {:code => "salary:employer:bu", :charge_rate_code => 'salary:employer:bu', :title => "BU Arbeitgeber", :debit_account => Account.find_by_code("2020"), :credit_account => Account.find_by_code("5700"), :amount_relates_to => 'reference_amount'},

  {:code => "salary:employee:nbu", :charge_rate_code => 'salary:employee:nbu', :title => "NBU Arbeitnehmer", :debit_account => Account.find_by_code("2020"), :credit_account => Account.find_by_code("5000"), :amount_relates_to => 'reference_amount'},
  {:code => "salary:employer:nbu", :charge_rate_code => 'salary:employer:nbu', :title => "NBU Arbeitgeber", :debit_account => Account.find_by_code("2020"), :credit_account => Account.find_by_code("5700"), :amount_relates_to => 'reference_amount'},

  {:code => "salary:employer:fak", :charge_rate_code => 'salary:employer:fak', :title => "FAK Arbeitgeber", :debit_account => Account.find_by_code("2020"), :credit_account => Account.find_by_code("5700"), :amount_relates_to => 'reference_amount'},

  {:code => "salary:employer:vkb", :charge_rate_code => 'salary:employer:vkb', :title => "VKB Arbeitgeber", :debit_account => Account.find_by_code("2020"), :credit_account => Account.find_by_code("5700"), :amount_relates_to => 'reference_amount'},
])

# Asset
BookingTemplate.create!([
  {:code => "asset:activate", :title => "Aktivierung", :debit_account => Account.find_by_code("4000"), :credit_account => Account.find_by_code("1230"), :amount => 1, :amount_relates_to => 'reference_amount'},

  {:code => "asset:deprecation", :title => "Abschreibung linear 10%", :debit_account => Account.find_by_code("1230"), :credit_account => Account.find_by_code("6900"), :amount => 0.1, :amount_relates_to => 'reference_amount'},
])
