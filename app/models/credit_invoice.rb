class CreditInvoice < Invoice
  # Bookings
  def self.direct_account
    Account.find_by_code("2000")
  end
end
