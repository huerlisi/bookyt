# encoding: UTF-8

# Master Data
# ===========
# Swiss (German)

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


# Basic Accounts
Account.create!([
  {:code => "1000", :title => "Kasse", :account_type => current_assets},
  {:code => "1100", :title => "Debitoren", :account_type => current_assets, :tag_list => 'invoice:debit'},
  {:code => "3200", :title => "Waren-/Dienstleistungsertrag", :account_type => earnings, :tag_list => 'invoice:earnings, vat:credit'},
])

BankAccount.create!([
  {:code => "1020", :title => "Bankkonto", :account_type => current_assets, :tag_list => 'invoice:payment'},
])

# Basic Booking Templates
BookingTemplate.create!([
  {:code => "", :title => "Barkauf", :credit_account => Account.find_by_code("1000"), :debit_account => Account.tagged_with("invoice:costs").first},
  {:code => "", :title => "EC-Zahlung", :credit_account => Account.find_by_code("1020"), :debit_account => Account.tagged_with("invoice:costs").first},
  {:code => "", :title => "Barbezug für Kasse", :credit_account => Account.find_by_code("1020"), :debit_account => Account.find_by_code("1000")},
])

# Credit Invoices
Account.create!([
  {:code => "2000", :title => "Kreditoren", :account_type => outside_capital, :tag_list => 'invoice:credit'},
  {:code => "4000", :title => "Materialaufwand", :account_type => costs, :tag_list => 'invoice:costs, vat:debit'},
])

BookingTemplate.create!([
  {:tag_list => "use:credit_invoice", :title => "Kreditoren Rechnung", :credit_account => Account.tagged_with("invoice:credit").first, :debit_account => Account.tagged_with("invoice:costs").first, :amount => 1, :amount_relates_to => 'reference_amount'},
  {:tag_list => "use:credit_invoice", :title => "Mahnung", :credit_account => Account.tagged_with("invoice:credit").first, :debit_account => Account.tagged_with("invoice:costs").first},
  {:tag_list => "use:credit_invoice", :title => "Storno", :credit_account => Account.tagged_with("invoice:costs").first, :debit_account => Account.tagged_with("invoice:credit").first, :amount => 1, :amount_relates_to => 'reference_amount'},

  {:tag_list => "use:credit_invoice", :title => "Barzahlung", :credit_account => Account.find_by_code("1000"), :debit_account => Account.tagged_with("invoice:credit").first, :amount => 1, :amount_relates_to => 'reference_balance'},
  {:tag_list => "use:credit_invoice", :title => "Bankzahlung", :credit_account => Account.find_by_code("1020"), :debit_account => Account.tagged_with("invoice:credit").first, :amount => 1, :amount_relates_to => 'reference_balance'},
])

# DebitInvoice
Account.create!([
  {:code => "3900", :title => "Debitorenverlust", :account_type => costs},
])

BookingTemplate.create!([
  {:tag_list => "use:debit_invoice", :title => "Debitoren Rechnung", :credit_account => Account.tagged_with("invoice:earnings").first, :debit_account => Account.tagged_with("invoice:debit").first, :amount => 1, :amount_relates_to => 'reference_amount'},
  {:tag_list => "use:debit_invoice", :title => "Mahnung", :credit_account => Account.tagged_with("invoice:earnings").first, :debit_account => Account.tagged_with("invoice:debit").first},
  {:tag_list => "use:debit_invoice", :title => "Storno", :credit_account => Account.tagged_with("invoice:debit").first, :debit_account => Account.tagged_with("invoice:earnings").first, :amount => 1, :amount_relates_to => 'reference_amount'},

  {:tag_list => "use:debit_invoice", :title => "Barzahlung", :credit_account => Account.tagged_with("invoice:debit").first, :debit_account => Account.find_by_code("1000"), :amount => 1, :amount_relates_to => 'reference_balance'},
  {:tag_list => "use:debit_invoice", :title => "Bankzahlung", :credit_account => Account.tagged_with("invoice:debit").first, :debit_account => Account.find_by_code("1020"), :amount => 1, :amount_relates_to => 'reference_balance'},
])


# Vat Rates
ChargeRate.create!([
  {:code => 'vat:full', :title => "MWSt.", :duration_from => '2011-01-01', :rate => 8, :relative => true},
  {:code => 'vat:reduced', :title => "MWSt.", :duration_from => '2011-01-01', :rate => 2.5, :relative => true},
  {:code => 'vat:special', :title => "MWSt.", :duration_from => '2011-01-01', :rate => 3.8, :relative => true},
  {:code => 'vat:excluded', :title => "MWSt. befreit", :duration_from => '2011-01-01', :rate => 0, :relative => true},
])

CivilStatus.create!([
  {:name => "Ledig"},
  {:name => "Verheiratet"},
  {:name => "Geschieden"},
  {:name => "Verwitwet"}
])

Religion.create!([
  {:name => "Römisch-Katholisch"},
  {:name => "Reformiert"},
  {:name => "Orthodox"},
  {:name => "Islam"},
  {:name => "Jüdisch"},
  {:name => "Konfessionslos"}
])
