class CreditInvoice < Invoice
  # Bookings
  def self.direct_account
    Account.find_by_code("2000")
  end
  
  def direct_account
    self.class.direct_account
  end
end
