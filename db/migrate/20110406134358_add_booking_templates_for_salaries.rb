class AddBookingTemplatesForSalaries < ActiveRecord::Migration
  def self.up
    BookingTemplate.create!([
      {:code => "salary:invoice", :title => "Lohn", :debit_account => Account.find_by_code("2050"), :credit_account => Account.find_by_code("5000")},
      {:code => "salary:cancel", :title => "Storno", :debit_account => Account.find_by_code("5000"), :credit_account => Account.find_by_code("2050")},

      {:code => "salary:cash_payment", :title => "Barzahlung Lohn", :debit_account => Account.find_by_code("1000"), :credit_account => Account.find_by_code("2050")},    
      {:code => "salary:bank_payment", :title => "Bankzahlung Lohn", :debit_account => Account.find_by_code("1020"), :credit_account => Account.find_by_code("2050")},
    ])
  end

  def self.down
  end
end
