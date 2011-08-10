class DebitInvoice < Invoice
  # Accounts
  # ========
  def self.direct_account
    Account.find_by_code("1100")
  end

  def balance_account
    bookings.first.try(:credit_account)
  end

  def profit_account
    bookings.first.try(:debit_account)
  end
end
