# encoding: utf-8

# Master Data
# ===========
# Nederlands

# Account Types
# =============
current_assets, capital_assets, outside_capital, equity_capital, costs, earnings =
AccountType.create!([
  {:name => "current_assets", :title => "vlottende activa"},
  {:name => "capital_assets", :title => "vaste activa"},
  {:name => "outside_capital", :title => "passiva"},
  {:name => "equity_capital", :title => "eigen vermogen"},
  {:name => "costs", :title => "kosten"},
  {:name => "earnings", :title => "verdiensten"},
  # {:name => "revenue", :title => "omzet"},
])


# Basic Accounts
Account.create!([
  {:code => "1000", :title => "kasboek", :account_type => current_assets},
  {:code => "1100", :title => "debiteuren", :account_type => current_assets},
  {:code => "3200", :title => "inkomsten uit producten en diensten", :account_type => earnings},
])

BankAccount.create!([
  {:code => "1020", :title => "bankrekening", :account_type => current_assets},
])

# Basic Booking Templates
BookingTemplate.create!([
  {:code => "", :title => "aankoop in contanten", :debit_account => Account.find_by_code("1000"), :credit_account => Account.find_by_code("4000")},
  {:code => "", :title => "aankoop via bankrekening", :debit_account => Account.find_by_code("1020"), :credit_account => Account.find_by_code("4000")},
  {:code => "", :title => "geld opnemen voor kas", :debit_account => Account.find_by_code("1020"), :credit_account => Account.find_by_code("1000")},
])

# Credit Invoices
Account.create!([
  {:code => "2000", :title => "crediteuren", :account_type => outside_capital},
  {:code => "4000", :title => "voorraad", :account_type => costs},
])

BookingTemplate.create!([
  {:code => "credit_invoice:invoice", :title => "factuur leverancier (crediteur)", :debit_account => Account.find_by_code("2000"), :credit_account => Account.find_by_code("4000"), :amount => 1, :amount_relates_to => 'reference_amount'},
  {:code => "credit_invoice:reminder", :title => "herinnering", :debit_account => Account.find_by_code("2000"), :credit_account => Account.find_by_code("4000")},
  {:code => "credit_invoice:cancel", :title => "annulering", :debit_account => Account.find_by_code("4000"), :credit_account => Account.find_by_code("2000"), :amount => 1, :amount_relates_to => 'reference_amount'},

  {:code => "credit_invoice:cash_payment", :title => "betaling in contanten", :debit_account => Account.find_by_code("1000"), :credit_account => Account.find_by_code("2000"), :amount => 1, :amount_relates_to => 'reference_balance'},
  {:code => "credit_invoice:bank_payment", :title => "betaling op bankrekening", :debit_account => Account.find_by_code("1020"), :credit_account => Account.find_by_code("2000"), :amount => 1, :amount_relates_to => 'reference_balance'},
])

# DebitInvoice
Account.create!([
  {:code => "3900", :title => "afschrijving", :account_type => costs},
])

BookingTemplate.create!([
  {:code => "debit_invoice:invoice", :title => "factuur klant (debiteur)", :debit_account => Account.find_by_code("3200"), :credit_account => Account.find_by_code("1100"), :amount => 1, :amount_relates_to => 'reference_amount'},
  {:code => "debit_invoice:reminder", :title => "herinnering", :debit_account => Account.find_by_code("3200"), :credit_account => Account.find_by_code("1100")},
  {:code => "debit_invoice:cancel", :title => "annulering", :debit_account => Account.find_by_code("1100"), :credit_account => Account.find_by_code("3200"), :amount => 1, :amount_relates_to => 'reference_amount'},

  {:code => "debit_invoice:cash_payment", :title => "betaling in contanten", :debit_account => Account.find_by_code("1100"), :credit_account => Account.find_by_code("1000"), :amount => 1, :amount_relates_to => 'reference_balance'},
  {:code => "debit_invoice:bank_payment", :title => "betaling op bankrekening", :debit_account => Account.find_by_code("1100"), :credit_account => Account.find_by_code("1020"), :amount => 1, :amount_relates_to => 'reference_balance'},
])
