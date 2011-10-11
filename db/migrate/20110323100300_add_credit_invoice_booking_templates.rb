class AddCreditInvoiceBookingTemplates < ActiveRecord::Migration
  def self.add(klass, key, descriptions)
    for description in descriptions
      klass.send("find_or_create_by_#{key.to_s}", description)
    end
  end

  def self.up
    add(Account, :code, [
      {:code => "2001", :title => "Kreditoren", :account_type => AccountType.find_by_name('outside_capital')},
      {:code => "4000", :title => "Materialaufwand", :account_type => AccountType.find_by_name('costs')},
    ])

    add(BookingTemplate, :code, [
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
