class AddDebitInvoiceBookingTemplates < ActiveRecord::Migration
  def self.up
    BookingTemplate.create!([
      {:code => "debit_invoice:invoice", :title => "Debitoren Rechnung", :debit_account => Account.find_by_code("3200"), :credit_account => Account.find_by_code("1100")},
      {:code => "debit_invoice:reminder", :title => "Mahnung", :debit_account => Account.find_by_code("3200"), :credit_account => Account.find_by_code("1100")},
      {:code => "debit_invoice:cancel", :title => "Storno", :debit_account => Account.find_by_code("1100"), :credit_account => Account.find_by_code("3200")},

      {:code => "debit_invoice:cash_payment", :title => "Barzahlung", :debit_account => Account.find_by_code("1100"), :credit_account => Account.find_by_code("1000")},
      {:code => "debit_invoice:bank_payment", :title => "Bankzahlung", :debit_account => Account.find_by_code("1100"), :credit_account => Account.find_by_code("1020")},
    ])
  end

  def self.down
  end
end
