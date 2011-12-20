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


# Basic Accounts
Account.create!([
  {:code => "1000", :title => "Kasse", :account_type => current_assets},
  {:code => "1100", :title => "Debitoren", :account_type => current_assets},
  {:code => "3200", :title => "Waren-/Dienstleistungsertrag", :account_type => earnings},
])

BankAccount.create!([
  {:code => "1020", :title => "Bankkonto", :account_type => current_assets},
])

# Basic Booking Templates
BookingTemplate.create!([
  {:code => "", :title => "Barkauf", :debit_account => Account.find_by_code("1000"), :credit_account => Account.find_by_code("4000")},
  {:code => "", :title => "EC-Zahlung", :debit_account => Account.find_by_code("1020"), :credit_account => Account.find_by_code("4000")},
  {:code => "", :title => "Barbezug für Kasse", :debit_account => Account.find_by_code("1020"), :credit_account => Account.find_by_code("1000")},
])

# Credit Invoices
Account.create!([
  {:code => "2000", :title => "Kreditoren", :account_type => outside_capital},
  {:code => "4000", :title => "Materialaufwand", :account_type => costs},
])

BookingTemplate.create!([
  {:code => "credit_invoice:invoice", :title => "Kreditoren Rechnung", :debit_account => Account.find_by_code("2000"), :credit_account => Account.find_by_code("4000"), :amount => 1, :amount_relates_to => 'reference_amount'},
  {:code => "credit_invoice:reminder", :title => "Mahnung", :debit_account => Account.find_by_code("2000"), :credit_account => Account.find_by_code("4000")},
  {:code => "credit_invoice:cancel", :title => "Storno", :debit_account => Account.find_by_code("4000"), :credit_account => Account.find_by_code("2000"), :amount => 1, :amount_relates_to => 'reference_amount'},

  {:code => "credit_invoice:cash_payment", :title => "Barzahlung", :debit_account => Account.find_by_code("1000"), :credit_account => Account.find_by_code("2000"), :amount => 1, :amount_relates_to => 'reference_balance'},
  {:code => "credit_invoice:bank_payment", :title => "Bankzahlung", :debit_account => Account.find_by_code("1020"), :credit_account => Account.find_by_code("2000"), :amount => 1, :amount_relates_to => 'reference_balance'},
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
  {:code => "debit_invoice:bank_payment", :title => "Bankzahlung", :debit_account => Account.find_by_code("1100"), :credit_account => Account.find_by_code("1020"), :amount => 1, :amount_relates_to => 'reference_balance'},
])
