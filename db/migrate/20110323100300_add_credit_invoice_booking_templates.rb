class AddCreditInvoiceBookingTemplates < ActiveRecord::Migration
  def self.up
    Account.create!([
      {:code => "2000", :title => "Kreditoren"},
      {:code => "4000", :title => "Materialaufwand"},
    ])

    BookingTemplate.create!([
      {:code => "credit_invoice:invoice", :title => "Kreditoren Rechnung", :debit_account => Account.find_by_code("2000"), :credit_account => Account.find_by_code("4000")},
      {:code => "credit_invoice:reminder", :title => "Mahnung", :debit_account => Account.find_by_code("2000"), :credit_account => Account.find_by_code("4000")},
      {:code => "credit_invoice:cancel", :title => "Storno", :debit_account => Account.find_by_code("4000"), :credit_account => Account.find_by_code("2000")},

      {:code => "credit_invoice:cash_payment", :title => "Barzahlung", :debit_account => Account.find_by_code("1000"), :credit_account => Account.find_by_code("2000")},
      {:code => "credit_invoice:bank_payment", :title => "Bankzahlung", :debit_account => Account.find_by_code("1020"), :credit_account => Account.find_by_code("2000")},
    ])
  end

  def self.down
  end
end
