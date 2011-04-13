class DebitInvoice < Invoice
  # Accounts
  # ========
  def self.direct_account
    Account.find_by_code("1100")
  end

  def balance_account
    bookings.first.credit_account
  end
  
  def profit_account
    bookings.first.debit_account
  end
end
