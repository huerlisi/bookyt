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
  {:code => "1100", :title => "debiteuren", :account_type => current_assets, :tag_list => 'invoice:debit'},
  {:code => "3200", :title => "inkomsten uit producten en diensten", :account_type => earnings, :tag_list => 'invoice:earnings, vat:credit'},
])

BankAccount.create!([
  {:code => "1020", :title => "bankrekening", :account_type => current_assets, :tag_list => 'invoice:payment'},
])

# Basic Booking Templates
BookingTemplate.create!([
  {:code => "", :title => "aankoop in contanten", :credit__account => Account.find_by_code("1000"), :debit_account => Account.find_by_code("4000")},
  {:code => "", :title => "aankoop via bankrekening", :credit__account => Account.find_by_code("1020"), :debit_account => Account.find_by_code("4000")},
  {:code => "", :title => "geld opnemen voor kas", :credit__account => Account.find_by_code("1020"), :debit_account => Account.find_by_code("1000")},
])

# Credit Invoices
Account.create!([
  {:code => "2000", :title => "crediteuren", :account_type => outside_capital, :tag_list => 'invoice:credit'},
  {:code => "4000", :title => "voorraad", :account_type => costs, :tag_list => 'invoice:costs, vat:debit'},
])

BookingTemplate.create!([
  {:code => "credit_invoice:invoice", :title => "factuur leverancier (crediteur)", :credit__account => Account.find_by_code("2000"), :debit_account => Account.find_by_code("4000"), :amount => 1, :amount_relates_to => 'reference_amount'},
  {:code => "credit_invoice:reminder", :title => "herinnering", :credit__account => Account.find_by_code("2000"), :debit_account => Account.find_by_code("4000")},
  {:code => "credit_invoice:cancel", :title => "annulering", :credit__account => Account.find_by_code("4000"), :debit_account => Account.find_by_code("2000"), :amount => 1, :amount_relates_to => 'reference_amount'},

  {:code => "credit_invoice:cash_payment", :title => "betaling in contanten", :credit__account => Account.find_by_code("1000"), :debit_account => Account.find_by_code("2000"), :amount => 1, :amount_relates_to => 'reference_balance'},
  {:code => "credit_invoice:bank_payment", :title => "betaling op bankrekening", :credit__account => Account.find_by_code("1020"), :debit_account => Account.find_by_code("2000"), :amount => 1, :amount_relates_to => 'reference_balance'},
])

# DebitInvoice
Account.create!([
  {:code => "3900", :title => "afschrijving", :account_type => costs},
])

BookingTemplate.create!([
  {:code => "debit_invoice:invoice", :title => "factuur klant (debiteur)", :credit__account => Account.find_by_code("3200"), :debit_account => Account.find_by_code("1100"), :amount => 1, :amount_relates_to => 'reference_amount'},
  {:code => "debit_invoice:reminder", :title => "herinnering", :credit__account => Account.find_by_code("3200"), :debit_account => Account.find_by_code("1100")},
  {:code => "debit_invoice:cancel", :title => "annulering", :credit__account => Account.find_by_code("1100"), :debit_account => Account.find_by_code("3200"), :amount => 1, :amount_relates_to => 'reference_amount'},

  {:code => "debit_invoice:cash_payment", :title => "betaling in contanten", :credit__account => Account.find_by_code("1100"), :debit_account => Account.find_by_code("1000"), :amount => 1, :amount_relates_to => 'reference_balance'},
  {:code => "debit_invoice:bank_payment", :title => "betaling op bankrekening", :credit__account => Account.find_by_code("1100"), :debit_account => Account.find_by_code("1020"), :amount => 1, :amount_relates_to => 'reference_balance'},
])
